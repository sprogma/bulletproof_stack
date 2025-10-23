using System;
using System.IO;
using System.Text.Json;
using System.Collections.Generic;
using System.Linq;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Windows.Forms;
using System.Numerics;
using System.Runtime.InteropServices; 


public class ProfileData
{
    public List<ProfileNode> Nodes { get; set; }
    public List<ProfileFlow> Flow { get; set; }
}


public class ProfileFlow
{
    public string From { get; set; }
    public string To { get; set; }
}


public class ProfileNode
{
    public string Key { get; set; }
    public string Name { get; set; }
    public bool Ptrptr { get; set; }
    public int Address { get; set; }
    public byte Opcode { get; set; }
    public int[] Args { get; set; }
    public ProfileDependence[] Deps { get; set; }
}


public class ProfileDependence
{
    public int Start { get; set; }
    public int End { get; set; }
    public string[] Nodes { get; set; }
}


public class GraphNode
{
    public Vector2 Pos;
    public float Radius;
    public ProfileNode Node;
    public List<GraphEdge> Edges;
    

    public GraphNode(ProfileNode node)
    {
        Random random = new Random();
        float x = (float)(random.NextDouble() * 900 - 450);
        float y = (float)(random.NextDouble() * 900 - 450);
        Pos = new Vector2(x, y);
        Radius = 18.0f;
        Node = node;
        Edges = new();
    }
}

public class GraphEdge
{
    public Vector2[] Pos;
    public GraphNode From;
    public GraphNode To;
    public bool FlowEdge;

    public GraphEdge(GraphNode from, GraphNode to, bool flowEdge)
    {
        From = from;
        To = to;
        Pos = new Vector2[3];
        Random random = new Random();
        FlowEdge = flowEdge;
        for (int i = 0; i < Pos.Length; ++i)
        {
            Pos[i] = To.Pos * (float)(i / (Pos.Length - 1.0)) + From.Pos * (float)(1.0 - i / (Pos.Length - 1.0));
            Pos[i].X += (float)(random.NextDouble() * 1.0 - 0.5);
            Pos[i].Y += (float)(random.NextDouble() * 1.0 - 0.5);
        }
    }
}


class MouseDownFilter : IMessageFilter {
    public event EventHandler FormClicked;
    private int WM_LBUTTONDOWN = 0x201;
    private Form form = null;

    [DllImport("user32.dll")]
    public static extern bool IsChild(IntPtr hWndParent, IntPtr hWnd);

    public MouseDownFilter(Form f) {
        form = f;
    }

    public bool PreFilterMessage(ref Message m) {
        if (m.Msg == WM_LBUTTONDOWN) {
            if (Form.ActiveForm != null && Form.ActiveForm.Equals(form)) {
                OnFormClicked();
            }
        }
        return false;
    }

    protected void OnFormClicked() {
        if (FormClicked != null) {
            FormClicked(form, EventArgs.Empty);
        }
    }
}



public class SimpleGraphForm : Form
{
    static ProfileData data;
    static List<GraphEdge> edges;
    static List<GraphNode> nodes;
    static float Temperature;

    const float Gather = 0.15f;
    const float GatherToZero = 0.01f;
    const float Push = 46.0f;
    const float JoiningFlowEdge = 0.15f;
    const float Joining = 0.15f;

    Vector2 Camera = new (0, 0);

    public SimpleGraphForm()
    {
        this.Text = "Data Graph";
        this.ClientSize = new Size(1600, 900);
        this.DoubleBuffered = true;

        System.Windows.Forms.Timer timer = new System.Windows.Forms.Timer();
        timer.Interval = 1;
        timer.Tick += Timer_Tick;
        timer.Start();

        MouseDownFilter mouseFilter = new MouseDownFilter(this);
        mouseFilter.FormClicked += mouseFilter_FormClicked;
        Application.AddMessageFilter(mouseFilter);
        
        Temperature = 1000.0f;
    }

    static public void ProcessPhysics()
    {
        // foreach node: find new position 
        IEnumerable<Vector2> dots = nodes.Select(x => x.Pos).Concat(edges.Where(x => x.FlowEdge).SelectMany(x => x.Pos));
        foreach (var node in nodes)
        {
            foreach (Vector2 dot in dots)
            {
                if (dot != node.Pos)
                {
                    // push 
                    float distance = Vector2.Distance(dot, node.Pos);
                    distance *= distance;
                    node.Pos += Vector2.Normalize(node.Pos - dot) * (float)(Push / (1.0 + distance));
                }
            }
        }
        foreach (var edge in edges)
        {
            for (int i = 0; i < edge.Pos.Length; ++i)
            {
                foreach (Vector2 dot in dots)
                {
                    if (dot != edge.Pos[i])
                    {
                        // push 
                        float distance = Vector2.Distance(dot, edge.Pos[i]);
                        distance *= distance;
                        edge.Pos[i] += Vector2.Normalize(edge.Pos[i] - dot) * (float)(Push / (1.0 + distance));
                    }
                }
                if (!edge.FlowEdge)
                {
                    foreach (Vector2 dot in edge.Pos)
                    {
                        if (dot != edge.Pos[i])
                        {
                            // push 
                            float distance = Vector2.Distance(dot, edge.Pos[i]);
                            distance *= distance;
                            edge.Pos[i] += 5.0f * Vector2.Normalize(edge.Pos[i] - dot) * (float)(Push / (1.0 + distance));
                        }
                    }
                }
            }
        }
        // gather 
        foreach (var edge in edges)
        {
            for (int i = 1; i < edge.Pos.Length; ++i)
            {
                float distance = Vector2.Distance(edge.Pos[i - 1], edge.Pos[i]);
                edge.Pos[i]     += Vector2.Normalize(edge.Pos[i - 1] - edge.Pos[i]) * distance * Gather / 2.0f; 
                edge.Pos[i - 1] -= Vector2.Normalize(edge.Pos[i - 1] - edge.Pos[i]) * distance * Gather / 2.0f;
            }
                // gather nodes 
            if (edge.FlowEdge)
            {
                {
                    float distance = Vector2.Distance(edge.From.Pos, edge.Pos[0]);
                    distance -= edge.From.Radius + 0.5f;
                    distance = Math.Max(distance * JoiningFlowEdge, 0.0f);
                    /* move both points */
                    edge.From.Pos += Vector2.Normalize(edge.Pos[0] - edge.From.Pos) * distance / 2.0f;
                    edge.Pos[0]   -= Vector2.Normalize(edge.Pos[0] - edge.From.Pos) * distance / 2.0f;
                }
                {
                    float distance = Vector2.Distance(edge.To.Pos, edge.Pos[^1]);
                    distance -= edge.To.Radius + 0.5f;
                    distance = Math.Max(distance * JoiningFlowEdge, 0.0f);
                    /* move both points */
                    edge.To.Pos  += Vector2.Normalize(edge.Pos[^1] - edge.To.Pos) * distance / 2.0f;
                    edge.Pos[^1] -= Vector2.Normalize(edge.Pos[^1] - edge.To.Pos) * distance / 2.0f;
                }
            }
            else
            {
                {
                    float distance = Vector2.Distance(edge.From.Pos, edge.Pos[0]);
                    distance -= edge.From.Radius + 0.5f;
                    distance = Math.Max(distance * Joining, 0.0f);
                    /* move both points */
                    edge.From.Pos += Vector2.Normalize(edge.Pos[0] - edge.From.Pos) * distance * 0.05f;
                    edge.Pos[0] -= Vector2.Normalize(edge.Pos[0] - edge.From.Pos) * distance * 0.95f;
                }
                {
                    float distance = Vector2.Distance(edge.To.Pos, edge.Pos[^1]);
                    distance -= edge.To.Radius + 0.5f;
                    distance = Math.Max(distance * Joining, 0.0f);
                    /* move both points */
                    edge.To.Pos  += Vector2.Normalize(edge.Pos[^1] - edge.To.Pos) * distance * 0.05f;
                    edge.Pos[^1] -= Vector2.Normalize(edge.Pos[^1] - edge.To.Pos) * distance * 0.95f;
                } 
            }
        }

        Random random = new Random();
        foreach (var node in nodes)
        {
            /* random shuffling */
            node.Pos.X += ((float)random.NextDouble() * 2.0f - 1.0f) * Temperature;
            node.Pos.Y += ((float)random.NextDouble() * 2.0f - 1.0f) * Temperature;
            /* little pressure to zero */
            node.Pos += Vector2.Normalize(-node.Pos) * GatherToZero;
        }
        foreach (var edge in edges)
        {
            /* random shuffling */
            for (int i = 0; i < edge.Pos.Length; ++i)
            {
                edge.Pos[i].X += ((float)random.NextDouble() * 2.0f - 1.0f) * Temperature;
                edge.Pos[i].Y += ((float)random.NextDouble() * 2.0f - 1.0f) * Temperature;
            }
        }
        Temperature *= 0.99f;
    }

    protected override void OnPaint(PaintEventArgs e)
    {
        base.OnPaint(e);
        
        e.Graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
        
        using var font = new Font("Segoe UI", 12, FontStyle.Bold);
        using var brush = new SolidBrush(Color.Red);
        using var dataPen = new Pen(Color.Blue, 2);
        using var flowPen = new Pen(Color.Green, 2);
        StringFormat centerStrFormat = new StringFormat();
        centerStrFormat.LineAlignment = StringAlignment.Center;
        centerStrFormat.Alignment = StringAlignment.Center;
        
        dataPen.CustomEndCap = new AdjustableArrowCap(5, 5);
        flowPen.CustomEndCap = new AdjustableArrowCap(5, 5);
        
        /*using GraphicsPath capPath = new GraphicsPath();
        
        
        capPath.AddLine(-20, 0, 20, 0);
        capPath.AddLine(-20, 0, 0, 20);
        capPath.AddLine(0, 20, 20, 0);

        dataPen.CustomEndCap = new System.Drawing.Drawing2D.CustomLineCap(null, capPath);
*/
        for (int i = 0; i < 100; ++i)
        {
            ProcessPhysics();
        }
        
        int cx = (int)Camera.X - ClientRectangle.Width/2;
        int cy = (int)Camera.Y - ClientRectangle.Height/2;
        
        Graphics g = e.Graphics;
        g.Clear(Color.White);

        // 1. draw edges 
        foreach (var edge in edges.Where(x => x.FlowEdge))
        {
            g.DrawCurve(flowPen, edge.Pos.Select(x => new Point((int)x.X - cx, (int)x.Y - cy)).ToArray());
        }
        
        foreach (var edge in edges.Where(x => !x.FlowEdge))
        {
            g.DrawCurve(dataPen, edge.Pos.Select(x => new Point((int)x.X - cx, (int)x.Y - cy)).ToArray());
        }
        
        // 2. draw nodes 
        foreach (var node in nodes)
        {
            g.FillEllipse(Brushes.Black, node.Pos.X - node.Radius - cx, node.Pos.Y - node.Radius - cy, 2*node.Radius, 2*node.Radius);
            g.DrawString(node.Node.Name + (node.Node.Address-0x4000).ToString(), font, brush, new PointF(node.Pos.X - cx, node.Pos.Y - cy), centerStrFormat);
        }
    }



    private void mouseFilter_FormClicked(object sender, EventArgs e) 
    {
        Point pos = PointToClient(Cursor.Position);
        Vector2 mouse = new Vector2(pos.X - ClientRectangle.Width/2, pos.Y - ClientRectangle.Height/2) + Camera;
        
        foreach (var node in nodes)
        {
            //node.Node.Name = mouse.X.ToString() + "X" + mouse.Y.ToString() + ";";
        }
        
        // Update the mouse path with the mouse information
        // Point mouseDownLocation = new Point(e.X, e.Y);

        /*string? eventString = null;
        switch (e.Button) {
            case MouseButtons.Left:
                eventString = "L";
                break;
            case MouseButtons.Right:
                eventString = "R";
                break;
            case MouseButtons.Middle:
                eventString = "M";
                break;
            case MouseButtons.XButton1:
                eventString = "X1";
                break;
            case MouseButtons.XButton2:
                eventString = "X2";
                break;
            case MouseButtons.None:
            default:
                break;
        }*/

        /*if (eventString != null) 
        {
            mousePath.AddString(eventString, FontFamily.GenericSerif, (int)FontStyle.Bold, fontSize, mouseDownLocation, StringFormat.GenericDefault);
        }
        else 
        {
            mousePath.AddLine(mouseDownLocation,mouseDownLocation);
        }*/


        
        this.Focus();
        this.Invalidate();
    }




    [STAThread]
    public static void RunForm(string filename)
    {
        // load graph from filename 
        string jsonString = File.ReadAllText(filename);
        data = JsonSerializer.Deserialize<ProfileData>(jsonString);
        if (data == null)
        {
            throw new Exception($"Error: can't parse json from {filename}");
        }

        edges = new();
        nodes = new();

        Dictionary<string, GraphNode> nodeKeys = new();
        foreach (var node in data.Nodes)
        {
            var gNode = new GraphNode(node);
            nodes.Add(gNode);
            nodeKeys[node.Key] = gNode;
        }
        /*foreach (var node in nodes)
        {
            foreach (var dep in node.Node.Deps)
            {
                // get node with this key 
                foreach (var depNode in dep.Nodes)
                {
                    edges.Add(new GraphEdge(nodeKeys[depNode], node, false));
                }
            }
        }*/
        foreach (var flow in data.Flow)
        {
            edges.Add(new GraphEdge(nodeKeys[flow.From], nodeKeys[flow.To], true));
        }


        Application.EnableVisualStyles();
        Application.SetCompatibleTextRenderingDefault(false);
        Application.Run(new SimpleGraphForm());
    }
    
    private void Timer_Tick(object sender, EventArgs e)
    {
        this.Invalidate();
    }
}

using System;
using System.IO;
using System.Text.Json;
using System.Collections.Generic;
using System.Linq;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Windows.Forms;
using System.Numerics;


public class ProfileData
{
    public List<ProfileNode> Nodes { get; set; }
    public List<string> Flow { get; set; }
}


public class ProfileNode
{
    public string Key { get; set; }
    public string Name { get; set; }
    public bool Ptrptr { get; set; }
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
        float x = (float)(random.NextDouble() * 300 - 150);
        float y = (float)(random.NextDouble() * 300 - 150);
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

    public GraphEdge(GraphNode from, GraphNode to)
    {
        From = from;
        To = to;
        Pos = new Vector2[10];
        Random random = new Random();
        for (int i = 0; i < 10; ++i)
        {
            Pos[i] = To.Pos * (float)(i / 9.0) + From.Pos * (float)(1.0 - i / 9.0);
            Pos[i].X += (float)(random.NextDouble() * 1.0 - 0.5);
            Pos[i].Y += (float)(random.NextDouble() * 1.0 - 0.5);
        }
    }
}


public class SimpleGraphForm : Form
{
    static ProfileData data;
    static List<GraphEdge> edges;
    static List<GraphNode> nodes;
    static float Temperature;

    const float Gather = 0.16f;
    const float Push = 16.0f;

    public SimpleGraphForm()
    {
        this.Text = "Data Graph";
        this.ClientSize = new Size(1600, 900);
        this.DoubleBuffered = true;

        System.Windows.Forms.Timer timer = new System.Windows.Forms.Timer();
        timer.Interval = 1;
        timer.Tick += Timer_Tick;
        timer.Start();

        Temperature = 10.0f;
    }

    static public void ProcessPhysics()
    {
        // foreach node: find new position 
        IEnumerable<Vector2> dots = nodes.Select(x => x.Pos).Concat(edges.SelectMany(x => x.Pos));
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
            {
                float distance = Vector2.Distance(edge.From.Pos, edge.Pos[0]);
                distance -= edge.From.Radius + 0.5f;
                distance = Math.Max(distance, 0.0f);
                /* move both points */
                edge.From.Pos += Vector2.Normalize(edge.Pos[0] - edge.From.Pos) * distance / 2.0f;
                edge.Pos[0]   -= Vector2.Normalize(edge.Pos[0] - edge.From.Pos) * distance / 2.0f;
            }
            {
                float distance = Vector2.Distance(edge.To.Pos, edge.Pos[^1]);
                distance -= edge.To.Radius + 0.5f;
                distance = Math.Max(distance, 0.0f);
                /* move both points */
                edge.To.Pos  += Vector2.Normalize(edge.Pos[^1] - edge.To.Pos) * distance / 2.0f;
                edge.Pos[^1] -= Vector2.Normalize(edge.Pos[^1] - edge.To.Pos) * distance / 2.0f;
            }
        }

        Random random = new Random();
        foreach (var node in nodes)
        {
            /* random shuffling */
            node.Pos.X += ((float)random.NextDouble() * 2.0f - 1.0f) * Temperature;
            node.Pos.Y += ((float)random.NextDouble() * 2.0f - 1.0f) * Temperature;
            /* little pressure to zero */
            node.Pos += Vector2.Normalize(-node.Pos) * 0.01f;
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
        Temperature *= 0.999f;
    }

    protected override void OnPaint(PaintEventArgs e)
    {
        base.OnPaint(e);
        
        e.Graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
        
        using var font = new Font("Segoe UI", 12, FontStyle.Bold);
        using var brush = new SolidBrush(Color.Red);
        using var dataPen = new Pen(Color.Blue, 2);
        StringFormat centerStrFormat = new StringFormat();
        centerStrFormat.LineAlignment = StringAlignment.Center;
        centerStrFormat.Alignment = StringAlignment.Center;
        
        dataPen.CustomEndCap = new AdjustableArrowCap(5, 5);
        
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
        
        int cx = -800;
        int cy = -450;
        
        Graphics g = e.Graphics;
        g.Clear(Color.White);

        
        // 1. draw edges 
        foreach (var edge in edges)
        {
            g.DrawCurve(dataPen, edge.Pos.Select(x => new Point((int)x.X - cx, (int)x.Y - cy)).ToArray());
            /* // [for debug]
            foreach (Vector2 x in edge.Pos)
            {
                g.FillEllipse(Brushes.Green, x.X - 5 - cx, x.Y - 5 - cy, 10, 10);
            }
            */
        }
        
        // 2. draw nodes 
        foreach (var node in nodes)
        {
            g.FillEllipse(Brushes.Black, node.Pos.X - node.Radius - cx, node.Pos.Y - node.Radius - cy, 2*node.Radius, 2*node.Radius);
            g.DrawString(node.Node.Name, font, brush, new PointF(node.Pos.X - cx, node.Pos.Y - cy), centerStrFormat);
        }

        return;

        /*using (var axisPen = new Pen(Color.Black, 2))
        {
            g.DrawLine(axisPen, 40, this.ClientSize.Height - 40, this.ClientSize.Width - 20, this.ClientSize.Height - 40);
            g.DrawLine(axisPen, 40, 20, 40, this.ClientSize.Height - 40);
        }


        using (var pen = new Pen(Color.Orange, 2))
        using (var fill = new SolidBrush(Color.FromArgb(60, Color.Orange)))
        {
            g.DrawEllipse(pen, 420, 50, 120, 80);
            g.FillEllipse(fill, 420, 50, 120, 80);
        }


        using (var font = new Font("Segoe UI", 9))
        using (var brush = new SolidBrush(Color.Black))
        {
            g.DrawString("0", font, brush, new PointF(30, this.ClientSize.Height - 35));
            g.DrawString("X", font, brush, new PointF(this.ClientSize.Width - 25, this.ClientSize.Height - 45));
            g.DrawString("Y", font, brush, new PointF(20, 10));
        }*/
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
        foreach (var node in nodes)
        {
            foreach (var dep in node.Node.Deps)
            {
                // get node with this key 
                foreach (var depNode in dep.Nodes)
                {
                    edges.Add(new GraphEdge(nodeKeys[depNode], node));
                }
            }
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

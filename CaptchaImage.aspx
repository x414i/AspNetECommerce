<%@ Page Language="C#" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Imaging" %>
<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        Random Rand = new Random();
        Bitmap Bep = new Bitmap(90,50);
        Graphics GFX = Graphics.FromImage(Bep);
        Font Fnt = new Font("impact", 13, FontStyle.Strikeout);
        int num = Rand.Next(100000, 999999);

        GFX.Clear(Color.White);
        GFX.DrawString(num.ToString(), Fnt, Brushes.Red, 15, 15);

        int RandY1 = Rand.Next(0, 50);
        int RandY2 =  Rand.Next(0, 50);
        GFX.DrawLine(Pens.Black, 0, RandY1, 90, RandY2);

        RandY1 = Rand.Next(0, 50);
        RandY2 =  Rand.Next(0, 50);
        GFX.DrawLine(Pens.Blue, 90, RandY1,0, RandY2);

        RandY1 = Rand.Next(0, 50);
        RandY2 =  Rand.Next(0, 50);
        GFX.DrawLine(Pens.Blue, 0, RandY1,90, RandY2);

        Bep.Save(Response.OutputStream, ImageFormat.Gif);

        Session["randnum"] = num;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>

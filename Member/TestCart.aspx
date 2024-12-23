<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        GridView1.DataSource = (DataTable)Session["items"];
        GridView1.DataBind();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
    <div>
    
        <asp:GridView ID="GridView1" runat="server" style="text-align: center">
        </asp:GridView>
    
    </div>
    </form>
</body>
</html>

<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>

<script runat="server">

    SqlConnection con = new SqlConnection("server=DESKTOP-J4JJ3J7\\SQLEXPRESS;database=COMPANY;integrated security=sspi");

    protected void btnLoginToEdit_Click(object sender, EventArgs e)
    {
        string sql = string.Format("select * from member where username='{0}' and Password='{1}'", txtUsername.Text, txtPass.Text);
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@user", txtUsername.Text);
        cmd.Parameters.AddWithValue("@pass", txtPass.Text);
        SqlDataReader r;
        con.Open();
        r = cmd.ExecuteReader();
        if (r.Read())
        {
            HttpCookie cookie = new HttpCookie("edit");
            cookie.Values.Add("user", txtUsername.Text);
            Response.Cookies.Add(cookie);
            con.Close();
            Response.Redirect("Edit.aspx");
        }
        else
        {
            string script = "alert('Username/Password Invalid');";
            ClientScript.RegisterStartupScript(this.GetType(), "LoginError", script, true);
            lblMas.Text = script;
            con.Close();
        }

    }


    protected void btnHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("index.html");
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login to Edit</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        table {
            margin: auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
        }
        .label {
            text-align: right;
            font-weight: bold;
            margin-right: 10px;
        }
        .input-field {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        .button:hover {
            background-color: #218838;
        }
        .message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table dir="rtl">
                <tr>
                    <td rowspan="4" style="text-align: center;">
                        <asp:Image ID="Image1" runat="server" Height="206px" Width="205px" ImageUrl="~/assets/noun-user-settings-1524729.png" />
                    </td>
                    <td colspan="2">
                        <h1>
                            <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Size="36pt" Text="تسجيل الدخول للتعديل" Font-Names="Cairo"></asp:Label>
                        </h1>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="13pt" ForeColor="#33CC33" Text="ادخل هذه الحقول"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="label">
                        <asp:Label ID="Label3" runat="server" Text="اسم المستخدم" Font-Names="Cairo"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" />
                    </td>
                </tr>
                <tr>
                    <td class="label">
                        <asp:Label ID="Label4" runat="server" Text="كلمة المرور" Font-Names="Cairo"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="input-field" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="message">
                        <br />
                        <br />
                        <asp:Label ID="lblMas" runat="server" ForeColor="Red"></asp:Label>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <asp:Button ID="btnLoginToEdit" runat="server" Text="تسجيل" OnClick="btnLoginToEdit_Click" CssClass="button" Font-Names="Cairo" Width="105px" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnHome" runat="server" Text="الصفحة الرئيسية" OnClick="btnHome_Click" CssClass="button" BackColor="#3399FF" Font-Names="Cairo" />
                    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>

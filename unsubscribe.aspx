<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>

<script runat="server">
    SqlConnection con = new SqlConnection("server=DESKTOP-J4JJ3J7\\SQLEXPRESS;database=COMPANY;integrated security=sspi");

    protected void btnUnsubscribe_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text;
        string query = "delete from member where  username=@user";
        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@user", username);
        try {
            con.Open();
            int result = cmd.ExecuteNonQuery();
            if (result > 0)
            {

                lblMas.Text = "Done :)";
 string script = "alert('تم الغاء الاشتراك');";
               ClientScript.RegisterStartupScript(this.GetType(), "LoginError", script, true);
            }else
            {
                lblMas.Text = "not found :|";
                 string script = "alert(' غير موجود ');";
               ClientScript.RegisterStartupScript(this.GetType(), "LoginError", script, true);
            }

        }
        catch(SqlException ex) {
            lblMas.Text = "Erorr : " + ex.Message;
        }
        finally { con.Close(); }
    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("index.html");
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Unsubscribe Form</title>
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
            margin-bottom: 20px;
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
                    <td colspan="2" style="text-align: center;">
                        <asp:Image ID="Image1" runat="server" Height="123px" Width="121px" ImageUrl="~/assets/noun-remove-user-220071.png" />
                        <h1>
                            <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Size="36pt" Text="الغاء الاشتراك" Font-Names="Cairo"></asp:Label>
                        </h1>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;" dir="rtl">
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="13pt" ForeColor="#33CC33" Text="ادخل الحقول"></asp:Label>
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
                        <asp:Label ID="lblMas" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <script>
                        function confirmDelete() {
                            var result = confirm("هل أنت متأكد من أنك تريد حذف الفئة؟");
                            if (result) {
                                return true;
                            } else {
                                return false; 
                            }
                        }
                    </script>
                    <td colspan="2" style="text-align: center;">
                        <asp:Button ID="btnUnsubscribe" runat="server" Text="الغاء الاشتراك" OnClientClick="return confirmDelete();" OnClick="btnUnsubscribe_Click" CssClass="button" Font-Names="Cairo" />
                    &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnHome" runat="server" Text="الصفحة الرئيسية" OnClick="btnHome_Click" CssClass="button" BackColor="#3399FF" Font-Names="Cairo" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
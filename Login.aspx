<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>

<script runat="server">
    SqlConnection con = new SqlConnection("server=DESKTOP-J4JJ3J7\\SQLEXPRESS;database=COMPANY;integrated security=sspi");
    protected void Login()
    {
        SqlCommand cmd = new SqlCommand(string.Format("select * from member where username='{0}' and password='{1}'",txtUsername.Text,txtPassword.Text),con);
        SqlDataReader read;
        try
        {
            con.Open();
            read = cmd.ExecuteReader();
            if (read.Read())
            {
                HttpCookie cookie = new HttpCookie("login");
                cookie.Values.Add("user",txtUsername.Text);
                cookie.Values.Add("pass", txtPassword.Text);
                if (cbxRemeberMe.Checked == true)
                    cookie.Expires = DateTime.MaxValue;

                Response.Cookies.Add(cookie);

                if(txtUsername.Text.ToLower()=="admin")
                {
                    Response.Redirect("Admin\\Admin.aspx");
                }
                else
                {
                    pnlLogin.Visible = false;
                    lblUser.Text = txtUsername.Text;
                    pnlWelcome.Visible = true;
                    //string script = "alert('Welcome, " + txtUsername.Text+ "');";
               // ClientScript.RegisterStartupScript(this.GetType(), "WelcomeMessage", script, true);
                }
            }
            else
            {
                 string script = "alert('Username/Password Invalid');";
                // ClientScript.RegisterStartupScript(this.GetType(), "LoginError", script, true);
                 ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('نجاح!', 'شكراً لتسجيلك!', 'erorr').then(() => { window.location='index,html'; });", true);
            }
        }
        catch (Exception ex)
        {
            lblMasg.Text = ex.Message;
        }
        finally
        {
            con.Close();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Login();
    }

    protected void lbtnSingOut_Click(object sender, EventArgs e)
    {
        HttpCookie cookieDelete = new HttpCookie("login");
        cookieDelete.Expires = DateTime.Now.AddDays(-1);
        Response.Cookies.Add(cookieDelete);
        lblUser.Text = "";
        pnlWelcome.Visible = false;
        pnlLogin.Visible = true;
        //JAVA-Script
       string script = @"
        if (confirm('هل انت متاكد من تسجيل الخروج ?')) {
            window.location = 'Login.aspx' 
        } else {
            window.location = 'index.html'; 
        }";
    ClientScript.RegisterStartupScript(this.GetType(), "ConfirmLogout", script, true);

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Request.Cookies["login"] != null) && (Request.Cookies["login"]["user"] != null) && (Request.Cookies["login"]["pass"] != null)){
            txtUsername.Text = Request.Cookies["login"]["user"];
            txtPassword.Text = Request.Cookies["login"]["pass"];
            cbxRemeberMe.Checked = true;
            Login();

        }
    }

    protected void lbtnMemberServices_Click(object sender, EventArgs e)
    {
        Response.Redirect("Member\\Member.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>
    <style type="text/css">
        .auto-style1 {
            font-size: large;
        }
        .auto-style2 {
            text-align: center;
        }
        .auto-style3 {
            width: 317px;
        }
        .auto-style5 {
            width: 8px;
        }
        .auto-style7 {
            text-align: center;
            width: 431px;
        }
    </style>
    <link rel="stylesheet" href="assets/style/login.css" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:Panel ID="pnlLogin" runat="server" Width="436px">
            <table>
                <tr>
                    <td class="auto-style2" colspan="3">
                        <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Names="Cairo" Font-Overline="False" Font-Size="32pt" Font-Underline="False" Text="Login Form"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td><strong>
                        <asp:Label ID="Label1" runat="server" CssClass="auto-style1" Text="Username :" Font-Names="Cairo"></asp:Label>
                        </strong></td>
                    <td class="auto-style3"><strong>
                        <asp:TextBox ID="txtUsername" runat="server" Width="284px"></asp:TextBox>
                        </strong></td>
                    <td class="auto-style5">&nbsp;</td>
                </tr>
                <tr>
                    <td><strong>
                        <asp:Label ID="Label2" runat="server" CssClass="auto-style1" Text="Password :" Font-Names="Cairo"></asp:Label>
                        </strong></td>
                    <td class="auto-style3"><strong>
                        <asp:TextBox ID="txtPassword" runat="server" Width="283px"></asp:TextBox>
                        </strong></td>
                    <td class="auto-style5">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2" colspan="3"><strong>
                        <asp:Label ID="lblMasg" runat="server" CssClass="auto-style1" Font-Names="Cairo" ForeColor="Red"></asp:Label>
                        </strong></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:CheckBox ID="cbxRemeberMe" runat="server" Text="Remember Me" Font-Names="Cairo" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="auto-style2">
                        <asp:Button ID="Button1" runat="server" Font-Bold="True" Font-Size="14pt" Text="Login" OnClick="Button1_Click" Font-Names="Cairo" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlWelcome" runat="server" Height="74px" Visible="False" Width="433px">
            <table>
                <tr>
                    <td class="auto-style7"><strong>
                        <asp:Label ID="Label3" runat="server" CssClass="auto-style1" ForeColor="#0066FF" Text="Welcome Back " Font-Names="Cairo"></asp:Label>
                        <asp:Label ID="lblUser" runat="server" Font-Names="Cairo"></asp:Label>
                        &nbsp;</strong></td>
                </tr>
                <tr>
                    <td class="auto-style7">
                        <strong>
                        <asp:LinkButton ID="lbtnSingOut" runat="server" OnClick="lbtnSingOut_Click" Font-Names="Cairo">Sign Out</asp:LinkButton>
                        <br />
                        <asp:LinkButton ID="lbtnMemberServices" runat="server" OnClick="lbtnMemberServices_Click" Font-Names="Cairo" >Member Services</asp:LinkButton>
                        </strong>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </form>
</body>
</html>
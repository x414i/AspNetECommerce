<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>

<script runat="server">
    SqlConnection con = new SqlConnection("server=DESKTOP-J4JJ3J7\\SQLEXPRESS;database=COMPANY;integrated security=sspi");

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (Session["randnum"].ToString() == txtCaptcha.Text)
        {
            if (cbTerms.Checked)
            {
                string sql = "INSERT INTO member VALUES(@fullname, @gender, @country, @phone, @email, @question, @answer, @username, @password)";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@fullname", txtFullName.Text);
                cmd.Parameters.AddWithValue("@gender", RBGender.SelectedIndex);
                cmd.Parameters.AddWithValue("@country", ddlCountry.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@question", txtQuestion.Text);
                cmd.Parameters.AddWithValue("@answer", txtAnswer.Text);
                cmd.Parameters.AddWithValue("@username", txtUser.Text);
                cmd.Parameters.AddWithValue("@password", txtPass.Text);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Write("Your Account Is Created.");
                }
                catch (SqlException ex)
                {
                    lblMasg.Text = ex.Number == 2627 ? "Please Change The Username" : "An Error: " + ex.Message;
                }
                finally
                {
                    con.Close();
                }
            }
            else
            {
                lblMasg.Text = "Agree to the Terms of The Company.";
            }
        }
        else
        {
            lblMasg.Text = "Captcha Image Incorrect.";
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        con.Open();
        con.Close();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration Form</title>
    <link rel="stylesheet" href="assets/style/signup.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Registration Form</h1>
            <asp:Label ID="lblMasg" runat="server" CssClass="error"></asp:Label>
            <div class="form-group">
                <asp:Label ID="Label1" runat="server" Text="Full Name"></asp:Label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="input-field"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label2" runat="server" Text="Gender"></asp:Label>
                <asp:RadioButtonList ID="RBGender" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True">Male</asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div class="form-group">
                <asp:Label ID="Label3" runat="server" Text="Country"></asp:Label>
                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="input-field">
                    <asp:ListItem Selected="True">Select Country</asp:ListItem>
                    <asp:ListItem>Misrata</asp:ListItem>
                    <asp:ListItem>Tripoli</asp:ListItem>
                    <asp:ListItem>Banghazi</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <asp:Label ID="Label4" runat="server" Text="Phone"></asp:Label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="input-field" TextMode="Phone"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label5" runat="server" Text="Email"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" TextMode="Email"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label6" runat="server" Text="Security Question"></asp:Label>
                <asp:TextBox ID="txtQuestion" runat="server" CssClass="input-field" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label7" runat="server" Text="Answer"></asp:Label>
                <asp:TextBox ID="txtAnswer" runat="server" CssClass="input-field" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label8" runat="server" Text="Username"></asp:Label>
                <asp:TextBox ID="txtUser" runat="server" CssClass="input-field"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label9" runat="server" Text="Password"></asp:Label>
                <asp:TextBox ID="txtPass" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label10" runat="server" Text="Confirm Password"></asp:Label>
                <asp:TextBox ID="txtCpass" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label11" runat="server" Text="Captcha Image"></asp:Label>
                <asp:Image ID="ImageCaptcha" runat="server" Height="100px" Width="169px" ImageUrl="~/CaptchaImage.aspx" />
            </div>
            <div class="form-group">
                <asp:Label ID="Label12" runat="server" Text="Captcha Text"></asp:Label>
                <asp:TextBox ID="txtCaptcha" runat="server" CssClass="input-field"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:CheckBox ID="cbTerms" runat="server" Text="I Agree to the <a href='terms.html'>Terms</a> of the Company" />
            </div>
            <div class="form-group">
                <asp:Button ID="btnRegister" runat="server" CssClass="button" Text="Register" OnClick="btnRegister_Click" />
            </div>
        </div>
    </form>
</body>
</html>
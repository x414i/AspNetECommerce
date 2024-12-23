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
                    //Response.Write("تم إنشاء حسابك بنجاح.");
                    // ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('شكراً لتسجيلك!'); window.location='index.html';", true);
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('نجاح!', 'شكراً لتسجيلك!', 'success').then(() => { window.location='index.html'; });", true);
                }
                catch (SqlException ex)
                {
                    lblMasg.Text = ex.Number == 2627 ? "يرجى تغيير اسم المستخدم" : "خطأ: " + ex.Message;
                    //string message = ex.Number == 2627 ? "يرجى تغيير اسم المستخدم" : "خطأ: " + ex.Message;
                    //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + message + "');", true);
                    string message = ex.Number == 2627 ? "يرجى تغيير اسم المستخدم" : "خطأ: " + ex.Message;
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('خطأ!', '" + message + "', 'error');", true);
                }
                finally
                {
                    con.Close();
                }
            }
            else
            {
                lblMasg.Text = "يرجى الموافقة على شروط الشركة.";
                // ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('يرجى الموافقة على شروط الشركة.');", true);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('تنبيه!', 'يرجى الموافقة على شروط الشركة.', 'warning');", true);
            }
        }
        else
        {
            lblMasg.Text = "نص الكابتشا غير صحيح.";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('خطأ!', 'نص الكابتشا غير صحيح.', 'error');", true);

           //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('نص الكابتشا غير صحيح.');", true);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        con.Open();
        con.Close();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" lang="ar">
<head runat="server">
    <!-- SweetAlert CSS -->
<link rel="stylesheet" href="https://unpkg.com/sweetalert2@11/dist/sweetalert2.min.css">

<!-- SweetAlert JS -->
<script src="https://unpkg.com/sweetalert2@11"></script>
    <meta charset="utf-8" />
    <title> انشاء حساب </title>
    <link rel="stylesheet" href="assets/style/signup.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>انشاء حساب</h1>
            <asp:Label ID="lblMasg" runat="server" CssClass="error"></asp:Label>
            <div class="form-group">
                <asp:Label ID="Label1" runat="server" Text="الاسم الكامل"></asp:Label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="input-field"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label2" runat="server" Text="الجنس" CssClass="gender-label"></asp:Label>
                <asp:RadioButtonList ID="RBGender" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True">ذكر</asp:ListItem>
                    <asp:ListItem>أنثى</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div class="form-group">
                <asp:Label ID="Label3" runat="server" Text="البلد"></asp:Label>
                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="input-field">
                    <asp:ListItem Selected="True">اختر البلد</asp:ListItem>
                    <asp:ListItem>مصراتة</asp:ListItem>
                    <asp:ListItem>طرابلس</asp:ListItem>
                    <asp:ListItem>بنغازي</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <asp:Label ID="Label4" runat="server" Text="الهاتف"></asp:Label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="input-field" TextMode="Phone"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label5" runat="server" Text="البريد الإلكتروني"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" TextMode="Email"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label6" runat="server" Text="سؤال الأمان"></asp:Label>
                <asp:TextBox ID="txtQuestion" runat="server" CssClass="input-field" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label7" runat="server" Text="الإجابة"></asp:Label>
                <asp:TextBox ID="txtAnswer" runat="server" CssClass="input-field" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label8" runat="server" Text="اسم المستخدم"></asp:Label>
                <asp:TextBox ID="txtUser" runat="server" CssClass="input-field"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label9" runat="server" Text="كلمة المرور"></asp:Label>
                <asp:TextBox ID="txtPass" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label10" runat="server" Text="تأكيد كلمة المرور"></asp:Label>
                <asp:TextBox ID="txtCpass" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox>
            </div>
            <div class="form-group">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <!--<asp:Label ID="Label11" runat="server" Text="صورة الكابتشا"></asp:Label>-->
                <asp:Image ID="ImageCaptcha" runat="server" Height="145px" Width="471px" ImageUrl="~/CaptchaImage.aspx" />
            </div>
            <div class="form-group">
                <asp:Label ID="Label12" runat="server" Text="نص الكابتشا" Font-Names="Cairo"></asp:Label>
                <asp:TextBox ID="txtCaptcha" runat="server" CssClass="input-field"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:CheckBox ID="cbTerms" runat="server" Text="أوافق على <a href='terms.html'>شروط</a> الشركة" Font-Names="Cairo" />
            </div>
            <div class="form-group">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnRegister" runat="server" CssClass="button" Text="تسجيل" OnClick="btnRegister_Click" Font-Bold="True" Font-Names="Cairo" Font-Size="16pt" Width="244px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnRegister0" runat="server" CssClass="button" Text="الصفحة الرئيسية" OnClick="btnRegister_Click" Font-Bold="True" Font-Names="Cairo" Font-Size="16pt" Width="213px" />
            &nbsp;</div>
        </div>
    </form>
</body>
</html>
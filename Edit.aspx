<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>

<script runat="server">

SqlConnection con = new SqlConnection("server=DESKTOP-J4JJ3J7\\SQLEXPRESS;database=COMPANY;integrated security=sspi");

protected void btnSave_Click(object sender, EventArgs e)
{
    SqlCommand cmd = new SqlCommand(string.Format("update member set fullname = '{0}',gender='{1}', country = '{2}', phone ='{3}', email = '{4}',question = '{5}', answer = '{6}', password='{7}' WHERE username = '{8}' ", txtFullName.Text, 0, ddlCountry.SelectedValue, txtPhone.Text, txtEmail.Text, txtQuestion.Text, txtAnswer.Text, txtPass.Text, txtUser.Text), con);

    con.Open();
    cmd.ExecuteNonQuery();
    con.Close();
          string script = "alert('تم حفظ البيانات بنجاح');";
    ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
        //Response.Redirect("index.html");
   // Response.Write("<font size=7 color=green>تم حفظ البيانات بنجاح.</font>");
}

protected void Page_Load(object sender, EventArgs e)
{
    if (!IsPostBack)
    {
        string strUser = "";
        if (Request.Cookies["edit"] != null)
            strUser = Request.Cookies["edit"]["user"].ToString();
        SqlCommand cmd = new SqlCommand(string.Format("select * from member where username='{0}'", strUser), con);
        SqlDataReader r;
        con.Open();
        r = cmd.ExecuteReader();
        if (r.Read())
        {
            txtFullName.Text = r[1].ToString();
            RBGender.SelectedIndex = 0;
            ddlCountry.SelectedValue = r[3].ToString();
            txtPhone.Text = r[4].ToString();
            txtEmail.Text = r[5].ToString();
            txtQuestion.Text = r[6].ToString();
            txtAnswer.Text = r[7].ToString();
            txtUser.Text = strUser;
        }
        else
            Response.Redirect("Update.aspx");
        con.Close();
    }
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>تعديل الملف الشخصي</title>
    <link rel="stylesheet" href="assets/style/edit.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="form-title">
                <asp:Label ID="lblHeaden" runat="server" Font-Bold="True" Text="تعديل الملف الشخصي"></asp:Label>
            </div>
            <div class="form-group">
                <label for="txtFullName">الاسم الكامل</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="RBGender">الجنس</label>
                <div class="radio-group">
                    <asp:RadioButtonList ID="RBGender" runat="server" RepeatDirection="Horizontal" style="text-align: center">
                        <asp:ListItem Value="0">ذكر</asp:ListItem>
                        <asp:ListItem Value="1">أنثى</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
            <div class="form-group">
                <label for="ddlCountry">البلد</label>
                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control">
                    <asp:ListItem Selected="True">Misrata</asp:ListItem>
                    <asp:ListItem>Tripoli</asp:ListItem>
                    <asp:ListItem>Banghazi</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="txtPhone">رقم الهاتف</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" TextMode="Phone"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtEmail">البريد الإلكتروني</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtQuestion">السؤال السري</label>
                <asp:TextBox ID="txtQuestion" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtAnswer">الإجابة</label>
                <asp:TextBox ID="txtAnswer" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtUser">اسم المستخدم</label>
                <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtPass">كلمة المرور</label>
                <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
            <div class="button-group">
                <asp:Button ID="btnSave" runat="server" CssClass="btn-save" Text="حفظ" OnClick="btnSave_Click" />
                <asp:Button ID="btnBack" runat="server" CssClass="btn-back" Text="العودة إلى الصفحة الرئيسية" OnClientClick="window.location.href='index.html'; return false;" />
               
            </div>
        </div>
    </form>
</body>
</html>

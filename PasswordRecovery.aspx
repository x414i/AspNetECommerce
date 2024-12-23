<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Net.Mail" %>
<!DOCTYPE html>

<script runat="server">

    protected void btnFollowing_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection("server=DESKTOP-J4JJ3J7\\SQLEXPRESS;database=COMPANY;integrated security=sspi");
        SqlCommand cmd = new SqlCommand("select * from member where username='"+txtUsername.Text+"'",con);
        SqlDataReader read;

        con.Open();
        read = cmd.ExecuteReader();
        if (read.Read())
        {
            ViewState["user"] = txtUsername.Text;
            ViewState["question"] = read["question"].ToString();
            ViewState["answer"] = read["answer"].ToString();
            ViewState["pass"] = read["password"].ToString();
            ViewState["email"] = read["email"].ToString();

            txtUser.Text = txtUsername.Text;
            txtQutesion.Text = ViewState["question"].ToString();

            MultiView1.ActiveViewIndex = 1;

        }
        else
        {
            string script = "alert('  اسم المستخدم غير موجود ');";
            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
            lblMas.Text = "Username Incorrect";
        }
        con.Close();
    }

    protected void btnFollowing0_Click(object sender, EventArgs e)
    {
        if (ViewState["answer"].ToString().ToLower() == txtAnswer.Text.ToLower())
            MultiView1.ActiveViewIndex = 2;
        else
        {
            string script = "alert('  الجواب خطا  ');";
            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
            lblMas0.Text = "The Answer Incorrect";
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection("server=DESKTOP-J4JJ3J7\\SQLEXPRESS;database=COMPANY;integrated security=sspi");
        SqlCommand cmd = new SqlCommand(string.Format("update member set password='{0}' where username='{1}'",txtPass.Text,ViewState["user"].ToString()),con);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        // lblTitle.Visible = false;
        MultiView1.ActiveViewIndex = -1;
            string script = "alert('تم حفظ البيانات بنجاح');";
    ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
        Response.Write("<font size=7 color=green>Your Password is Changed</font>");

    }

    protected void lbtnSendPass_Click(object sender, EventArgs e)
    {
        SmtpClient client = new SmtpClient("localhost", 8080);
        try
        {
            client.Send("company@exam.com", ViewState["email"].ToString(), "Welcome To Company <br> Password Recovery", "Your Password is : <br>" + ViewState["pass"].ToString());
            MultiView1.ActiveViewIndex = -1;
            Response.Write("<font size=7 color=green>Your Password Send</font>");
        }
        catch (Exception ex) { lblMas0.Text = ex.Message; }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>استرجاع كلمة المرور</title>
    <style type="text/css">
        @import url('https://fonts.googleapis.com/css2?family=Cairo&display=swap');
        
        body {
            font-family: 'Cairo', sans-serif;
            direction: rtl;
            text-align: center;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 400px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 10px;
        }

        .container h2 {
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: bold;
            color: #006600;
        }

        .label {
            font-size: 16px;
            text-align: right;
        }

        .input-field {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .input-field:focus {
            border-color: #4CAF50;
            outline: none;
        }

        .button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .button:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
            font-size: 14px;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .button-container a {
            text-decoration: none;
            color: #006600;
            font-size: 14px;
        }

        .button-container a:hover {
            color: #4CAF50;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container">
    
        <h2>استرجاع كلمة المرور</h2>
        
        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
            <asp:View ID="View1" runat="server">
                <asp:Label ID="Label1" runat="server" CssClass="label" Text="أدخل اسم المستخدم:"></asp:Label><br />
                <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field"></asp:TextBox>
                <asp:Label ID="lblMas" runat="server" CssClass="error-message"></asp:Label><br />
                <asp:Button ID="btnFollowing" runat="server" CssClass="button" OnClick="btnFollowing_Click" Text="استرجاع" />
            </asp:View>
            
            <asp:View ID="View2" runat="server">
                <asp:Label ID="Label2" runat="server" CssClass="label" Text="اسم المستخدم:"></asp:Label><br />
                <asp:TextBox ID="txtUser" runat="server" CssClass="input-field" ReadOnly="True"></asp:TextBox><br />
                
                <asp:Label ID="Label3" runat="server" CssClass="label" Text="سؤالك:"></asp:Label><br />
                <asp:TextBox ID="txtQutesion" runat="server" CssClass="input-field" ReadOnly="True"></asp:TextBox><br />
                
                <asp:Label ID="Label4" runat="server" CssClass="label" Text="إجابة:"></asp:Label><br />
                <asp:TextBox ID="txtAnswer" runat="server" CssClass="input-field" TextMode="MultiLine"></asp:TextBox><br />
                <asp:Label ID="lblMas0" runat="server" CssClass="error-message"></asp:Label><br />
                <asp:Button ID="btnFollowing0" runat="server" CssClass="button" OnClick="btnFollowing0_Click" Text="التالي" />
            </asp:View>

            <asp:View ID="View3" runat="server">
                <asp:Label ID="Label5" runat="server" CssClass="label" Text="أدخل كلمة المرور الجديدة:"></asp:Label><br />
                <asp:TextBox ID="txtPass" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox><br />
                <asp:Button ID="btnSave" runat="server" CssClass="button" OnClick="btnSave_Click" Text="حفظ" />
            </asp:View>
        </asp:MultiView>

        <div class="button-container">
            <asp:Button ID="btnBack" runat="server" CssClass="button" Text="العودة إلى الصفحة الرئيسية" OnClientClick="window.location.href='index.html'; return false;" />
        </div>
    </div>
    </form>
</body>
</html>

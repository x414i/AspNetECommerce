<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    SqlConnection con = new SqlConnection("server=DESKTOP-J4JJ3J7\\SQLEXPRESS;database=COMPANY;integrated security=sspi");

    protected void Search()
    {
        SqlCommand cmd = new SqlCommand(string.Format("select * from category where {0} like'%{1}%'",rblSearchBy.SelectedValue,txtSearch.Text),con);
        DataTable tblCat = new DataTable();

        con.Open();
        tblCat.Load(cmd.ExecuteReader());
        con.Close();
        gdvSearch.DataSource = tblCat;
        gdvSearch.DataBind();

        gdvSearch.SelectedIndex = -1;

        btnEditData.Enabled = false;
        btnDel.Enabled = false;
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Search();
    }

    protected void gdvSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        btnEditData.Enabled = true;
        btnDel.Enabled = true;
    }

    protected void btnDel_Click(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand(string.Format("delete from category where catno={0}",gdvSearch.SelectedRow.Cells[1].Text),con);
        try {
            con.Open();
            cmd.ExecuteNonQuery();

            con.Close();

            lblMas.Text = "Category " + gdvSearch.SelectedRow.Cells[2].Text + " is deleted";
        }
        catch(Exception ex) { lblMas.Text = "Erorr : "+ex.Message; }
        Search();
    }

    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        lblTitle.Text = "Add New";
        ViewState["type"] = "add";
        txtCatNO.Text = "";
        txtCatNO.ReadOnly = false;
        txtCatName.Text = "";
        txtDescription.Text = "";
        imgCat.Visible = false;
        lblMas2.Text = "";
        MultiView1.ActiveViewIndex = 1;
    }

   protected void btnSave_Click(object sender, EventArgs e)
{
    string commandText;
    if (ViewState["type"].ToString() == "add")
    {
        commandText = string.Format("INSERT INTO category VALUES ({0}, '{1}', '{2}')", 
            txtCatNO.Text, txtCatName.Text, txtDescription.Text);
    }
    else
    {
        commandText = string.Format("UPDATE category SET catname = '{0}', description = '{1}' WHERE catno = {2}", 
            txtCatName.Text, txtDescription.Text, txtCatNO.Text);
    }

    try 
    {
        using (SqlCommand cmd = new SqlCommand(commandText, con))
        {
            con.Open();
            cmd.ExecuteNonQuery();
            MultiView1.ActiveViewIndex = 0;

            if (fupCatImg.HasFile)
            {
                fupCatImg.SaveAs(Server.MapPath("CatImage\\" + txtCatNO.Text + ".jpg"));
            }
            lblMas.Text = "Category is " + ViewState["type"] + "ed";
        }
    }
    catch (Exception ex)
    {
        lblMas2.Text = "Error: " + ex.Message;
    }
    finally
    {
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
    }

    Search();
}

    protected void btnEditData_Click(object sender, EventArgs e)
    {
        lblTitle.Text = "Edit Data";
        ViewState["type"] = "edit";
        txtCatNO.Text = gdvSearch.SelectedRow.Cells[1].Text;
        txtCatNO.ReadOnly = true;
        txtCatName.Text = gdvSearch.SelectedRow.Cells[2].Text;
        txtDescription.Text = gdvSearch.SelectedRow.Cells[3].Text;
        imgCat.Visible = true;
        imgCat.ImageUrl = "CatImage\\"+txtCatNO.Text+".jpg";
        MultiView1.ActiveViewIndex = 1;
    }

    protected void btnCancle_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" type="text/css" href="style/cat.css" />
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <asp:Panel ID="Panel1" runat="server">
        <strong>
            <asp:Label ID="Label2" runat="server" Text="نموذج الفئة" Font-Names="impact" Font-Overline="True" Font-Underline="True"></asp:Label>
            <br />
        </strong>
        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
            <asp:View ID="View1" runat="server">
                <table align="center">
                    <tr>
                        <td>
                            &nbsp;&nbsp;<asp:Button ID="btnAddNew" runat="server" Text="إضافة فئة جديدة" OnClick="btnAddNew_Click" />
                            &nbsp;<asp:Button ID="btnEditData" runat="server" Enabled="False" OnClick="btnEditData_Click" Text="تعديل البيانات" />
                            &nbsp;
                            <script type="text/javascript">
    function confirmDelete() {
        // عرض رسالة التأكيد
        var result = confirm("هل أنت متأكد من أنك تريد حذف الفئة؟");
        if (result) {
            // إذا أكد المستخدم، دع الزر ينفذ الحدث
            return true; // يسمح بتنفيذ OnClick في C#
        } else {
            // إذا لم يؤكد المستخدم، تجاهل العملية
            return false; // يمنع تنفيذ OnClick في C#
        }
    }
</script>
                            <asp:Button ID="btnDel" runat="server" Enabled="False" OnClick="btnDel_Click" OnClientClick="return confirmDelete();" Text="حذف الفئة" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>
                                <asp:Label ID="Label3" runat="server" Text="البحث حسب:"></asp:Label>
                                &nbsp;<asp:RadioButtonList ID="rblSearchBy" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Selected="True" Value="catname">اسم الفئة</asp:ListItem>
                                    <asp:ListItem Value="description">الوصف</asp:ListItem>
                                </asp:RadioButtonList>
                            </strong>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" Text="بحث" OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>
                                <asp:Label ID="lblMas" runat="server"></asp:Label>
                            </strong>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="gdvSearch" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" OnSelectedIndexChanged="gdvSearch_SelectedIndexChanged">
                                <Columns>
                                    <asp:ButtonField ButtonType="Button" CommandName="Select" HeaderText="اختر الصف" Text="-&gt;" />
                                </Columns>
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="View2" runat="server">
                <table>
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Size="18pt"></asp:Label>
                        </td>
                        <td rowspan="5">
                            <asp:Image ID="imgCat" runat="server" Height="160px" Width="136px" Visible="False" ImageUrl="~/Admin/CatImage" />
                        </td>
                    </tr>
                    <tr>
                        <td><strong>
                            <asp:Label ID="Label4" runat="server" Text="رقم الفئة:"></asp:Label>
                        </strong></td>
                        <td>
                            <asp:TextBox ID="txtCatNO" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>
                            <asp:Label ID="Label8" runat="server" Text="اسم الفئة:"></asp:Label>
                        </strong></td>
                        <td>
                            <asp:TextBox ID="txtCatName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>
                            <asp:Label ID="Label9" runat="server" Text="الوصف:"></asp:Label>
                        </strong></td>
                        <td>
                            <asp:TextBox ID="txtDescription" runat="server" Height="49px" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>
                            <asp:Label ID="Label10" runat="server" Text="صورة الفئة:"></asp:Label>
                        </strong></td>
                        <td>
                            <asp:FileUpload ID="fupCatImg" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><strong>
                            <asp:Label ID="lblMas2" runat="server" ForeColor="Red"></asp:Label>
                        </strong></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <asp:Button ID="btnSave" runat="server" Text="حفظ" OnClick="btnSave_Click" />
                            &nbsp;
                            <asp:Button ID="btnCancle" runat="server" Text="إلغاء" OnClick="btnCancle_Click" />
                        </td>
                    </tr>
                </table>
            </asp:View>
        </asp:MultiView>
    </asp:Panel>
</asp:Content>
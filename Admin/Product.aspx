<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    SqlConnection con = new SqlConnection("server=DESKTOP-J4JJ3J7\\SQLEXPRESS;database=COMPANY;integrated security=sspi");

    protected void Search()
    {
        SqlCommand cmd = new SqlCommand(string.Format("select * from product where {0} like'%{1}%'",rblSearchBy.SelectedValue,txtSearch.Text),con);
        DataTable tblPro = new DataTable();
        try
        {
            con.Open();

            tblPro.Load(cmd.ExecuteReader());
            con.Close();
        }
        catch(Exception ex) { Console.WriteLine("Error : " + ex.Message); }
        gdvSearch.DataSource = tblPro;
        gdvSearch.DataBind();

        gdvSearch.SelectedIndex = -1;

        btnEditData.Enabled = false;
        btnDelPro.Enabled = false;
    }






    protected void btnSave_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        SqlCommand cmd = new SqlCommand("",con);
        if (ViewState["type"].ToString() == "add")
        {
            cmd.CommandText = string.Format("insert into product values({0},{1},'{2}',{3},{4},GetDate(),'{5}')",ddCat.SelectedValue, txtProID.Text, txtProName.Text,txtPrice.Text,txtQTY.Text, txtDescription.Text);
        }
        else
            cmd.CommandText = string.Format("update product set proname='{0}', price={1}, avqty={2}, writingdate=GetDate(), description='{3}' where catno={4} and proid={5}", txtProName.Text, txtPrice.Text, txtQTY.Text, txtDescription.Text, ddCat.SelectedValue, txtProID.Text);

        try {
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            MultiView1.ActiveViewIndex = 0;
            if (fupProImage.HasFile)
            {
                fupProImage.SaveAs(Server.MapPath("ProImage\\"+ddCat.SelectedValue+txtProID.Text+".jpg"));
            }
            lblMsg1.Text = "Product is "+ViewState["type"]+" ed";
        }
        catch(Exception ex)
        {
            lblMsg2.Text ="Erorr : "+ ex.Message;
        }
        Search();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Search();
    }

    protected void btnDelPro_Click(object sender, EventArgs e)
    {
        pnlConDel.Visible = true;
    }

    protected void btnNo_Click(object sender, EventArgs e)
    {
        pnlConDel.Visible = false;
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand(string.Format("delete from product where catno={0} and proid={1}",gdvSearch.SelectedRow.Cells[1].Text,gdvSearch.SelectedRow.Cells[2].Text),con);
        try {
            con.Open();
            cmd.ExecuteNonQuery();

            con.Close();

            lblMsg1.Text = "Product " + gdvSearch.SelectedRow.Cells[3].Text + " is deleted";
        }
        catch(Exception ex) { lblMsg1.Text = "Erorr : "+ex.Message; }
        pnlConDel.Visible = false;
        Search();

    }



    protected void gdvSearch_SelectedIndexChanged(object sender, EventArgs e)
    {

        btnEditData.Enabled = true;
        btnDelPro.Enabled = true;
    }

    protected void btnAddNewPro_Click(object sender, EventArgs e)
    {

        lblTitle.Text = "Add New";
        ViewState["type"] = "add";
        txtProID.Text = "";
        txtProID.ReadOnly = false;
        txtProName.Text = "";
        txtPrice.Text = "";
        txtQTY.Text = "";
        txtDescription.Text = "";
        imgPro.Visible = false;
        MultiView1.ActiveViewIndex = 1;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlCommand cmd = new SqlCommand("select * from category", con);
            DataTable tblCat = new DataTable();
            con.Open();
            tblCat.Load(cmd.ExecuteReader());
            con.Close();
            ddCat.DataSource = tblCat;
            ddCat.DataTextField = "catname";
            ddCat.DataValueField = "catno";
            ddCat.DataBind();
        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }

    protected void btnEditData_Click(object sender, EventArgs e)
    {
        lblTitle.Text = "Edit Data";
        ViewState["type"] = "edit";
        ddCat.SelectedValue = gdvSearch.SelectedRow.Cells[1].Text;
        txtProID.Text = gdvSearch.SelectedRow.Cells[2].Text;
        txtProName.Text = gdvSearch.SelectedRow.Cells[3].Text;
        txtPrice.Text = gdvSearch.SelectedRow.Cells[4].Text;
        txtQTY.Text = gdvSearch.SelectedRow.Cells[5].Text;
        txtDescription.Text = gdvSearch.SelectedRow.Cells[7].Text;
        imgPro.Visible = true;
        imgPro.ImageUrl = "ProImage\\"+ddCat.SelectedValue+txtProID.Text+".jpg";
        txtProID.ReadOnly = true;
        MultiView1.ActiveViewIndex = 1;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style6 {
            font-weight: bold;
        }
        .auto-style8 {
            margin-left: 0px;
        }
        .auto-style9 {
            width: 503px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                        <asp:Panel ID="Panel1" runat="server" Font-Names="Cairo">
                            <strong>
                            <asp:Label ID="Label2" runat="server" Text="المنتجات" CssClass="auto-style1" Font-Names="Cairo" Font-Overline="False" Font-Underline="False"></asp:Label>
                            <br />
                            </strong>
                            <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                                <asp:View ID="View1" runat="server">
                                    <table align="center">
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnAddNewPro" runat="server" BackColor="#99FFCC" BorderColor="#99FFCC" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Cairo" Font-Size="16pt" OnClick="btnAddNewPro_Click" Text="اضافة منتج" />
                                                &nbsp;
                                                <asp:Button ID="btnEditData" runat="server" BackColor="#99CCFF" BorderColor="#99CCFF" BorderStyle="Solid" BorderWidth="1px" Enabled="False" Font-Bold="True" Font-Names="Cairo" Font-Size="16pt" OnClick="btnEditData_Click" Text="تعديل بيانات منتج" />
                                                &nbsp;
                                                <asp:Button ID="btnDelPro" runat="server" Text="حذف منتج" OnClick="btnDelPro_Click" Enabled="False" BackColor="Red" BorderColor="#FF6666" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Cairo" Font-Size="16pt" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>
                                                <asp:Label ID="Label3" runat="server" CssClass="auto-style5"  Text="البحث بواسطة"></asp:Label>
                                                <asp:RadioButtonList ID="rblSearchBy" runat="server" RepeatDirection="Horizontal">
                                                    <asp:ListItem Selected="True" Value="proname">الاسم</asp:ListItem>
                                                    <asp:ListItem Value="description">الوصف</asp:ListItem>
                                                </asp:RadioButtonList>
                                                </strong></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtSearch" runat="server" Width="257px"></asp:TextBox>
                                                &nbsp;
                                                <asp:Button ID="btnSearch" runat="server" Text="بحث" OnClick="btnSearch_Click" ForeColor="#6797C8" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>
                                                <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                                                </strong></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Panel ID="pnlConDel" runat="server" Visible="False">
                                                    <table align="center" class="auto-style9">
                                                        <tr>
                                                            <td class="auto-style3">&nbsp; <strong>
                                                                <asp:Label ID="lblMsg3" runat="server" BackColor="#4A3C8C" BorderColor="#66FFFF" CssClass="auto-style5" Font-Bold="True" ForeColor="White">هل انت متاكد ؟؟</asp:Label>
                                                                </strong>&nbsp;&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label11" runat="server" Text="هل انت متاكد من حذف المنتج ؟؟؟" BackColor="#99CCFF"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Button ID="btnYes" runat="server" CssClass="auto-style8" Text="نعم, متاكد" Width="89px" OnClick="btnYes_Click" BackColor="#99FF66" BorderColor="#CCFF99" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Cairo" />
                                                                &nbsp;
                                                                <asp:Button ID="btnNo" runat="server" Text="لا, تراجع" Width="76px" OnClick="btnNo_Click" BackColor="#FF5050" BorderColor="#FF6666" BorderStyle="Solid" BorderWidth="1px" Font-Names="Cairo" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gdvSearch" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" OnSelectedIndexChanged="gdvSearch_SelectedIndexChanged">
                                                    <AlternatingRowStyle BackColor="#F7F7F7" />
                                                    <Columns>
                                                        <asp:ButtonField ButtonType="Button" CommandName="Select" HeaderText="Select Row" Text="&gt;" />
                                                    </Columns>
                                                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                    <SortedAscendingCellStyle BackColor="#F4F4FD" />
                                                    <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                                                    <SortedDescendingCellStyle BackColor="#D8D8F0" />
                                                    <SortedDescendingHeaderStyle BackColor="#3E3277" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:View>
                                <asp:View ID="View2" runat="server">
                                    <table align="center">
                                        <tr>
                                            <td colspan="2"><strong>
                                                <asp:Label ID="lblTitle" runat="server" CssClass="auto-style5"></asp:Label>
                                                </strong></td>
                                            <td rowspan="7">
                                                <asp:Image ID="imgPro" runat="server" Height="160px" Visible="False" Width="136px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label4" runat="server" Text="الاصناف"></asp:Label>
                                            </td>
                                            <td><strong>
                                                <asp:DropDownList ID="ddCat" runat="server" CssClass="auto-style6">
                                                </asp:DropDownList>
                                                </strong></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" Text="رقم المنتج"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtProID" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label6" runat="server" Text="اسم المنتج"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtProName" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label7" runat="server" Text="السعر"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label8" runat="server" Text="الكمية"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtQTY" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label9" runat="server" Text="الوصف"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label10" runat="server" Text="صورة المنتج"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:FileUpload ID="fupProImage" runat="server" />
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblMsg2" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>
                                                &nbsp;&nbsp;&nbsp;<asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="حفظ" BackColor="#66FF33" Font-Bold="True" Font-Names="Cairo" Font-Size="16pt" Width="83px" />
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="btnCancel" runat="server" BackColor="Red" Font-Bold="True" Font-Names="Cairo" Font-Size="16pt" OnClick="Button1_Click" Text="رجوع" Width="88px" />
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                </asp:View>
                            </asp:MultiView>
                        </asp:Panel>
                    </asp:Content>



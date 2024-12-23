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
    using (SqlCommand cmd = new SqlCommand(string.Format("delete from category where catno={0}", gdvSearch.SelectedRow.Cells[1].Text), con))
    {
        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
            lblMas.Text = "Category " + gdvSearch.SelectedRow.Cells[2].Text + " is deleted";
        }
        catch (Exception ex)
        {
            lblMas.Text = "Error: " + ex.Message;
        }
        finally
        {
            con.Close();
        }
    }
    Search();
}

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand("",con);
        if (ViewState["type"].ToString() == "add")
        {
            cmd.CommandText = string.Format("insert into category values({0},'{1}','{2}')", txtCatNO.Text, txtCatName.Text, txtDescription.Text);
        }
        else
            cmd.CommandText = string.Format("update category set catname='{0}' , description='{1}' where catno={2}",txtCatName.Text,txtDescription.Text,txtCatNO.Text);

        try {
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            MultiView1.ActiveViewIndex = 0;
            if (fupCatImg.HasFile)
            {
                fupCatImg.SaveAs(Server.MapPath("CatImage\\"+txtCatNO.Text+".jpg"));
            }
            lblMas.Text = "Category is "+ViewState["type"]+" ed";

        }
        catch(Exception ex)
        {
            lblMas2.Text ="Erorr : "+ ex.Message;
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
    <style type="text/css">
        .auto-style6 {
            font-size: large;
        }
        .auto-style7 {
            width: 36px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                        <asp:Panel ID="Panel1" runat="server">
                            <strong>
                            <asp:Label ID="Label2" runat="server" Text="Category Form" CssClass="auto-style1" Font-Names="impact" Font-Overline="True" Font-Underline="True"></asp:Label>
                            <br />
                            </strong>
                            <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                                <asp:View ID="View1" runat="server">
                                    <table align="center">
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnDel" runat="server" Text="DELETE CATEGORY" Enabled="False" OnClick="btnDel_Click" />
                                                &nbsp;&nbsp;
                                                <asp:Button ID="btnEditData" runat="server" Text="EDIT DATA" Enabled="False" OnClick="btnEditData_Click" />
                                                &nbsp;
                                                <asp:Button ID="btnAddNew" runat="server" Text="ADD NEW CATEGORY" OnClick="btnAddNew_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>
                                                <asp:Label ID="Label3" runat="server" CssClass="auto-style6" Text="SEARCH BY :"></asp:Label>
                                                &nbsp;<asp:RadioButtonList ID="rblSearchBy" runat="server" RepeatDirection="Horizontal">
                                                    <asp:ListItem Selected="True" Value="catname">Category Name</asp:ListItem>
                                                    <asp:ListItem Value="description">Description</asp:ListItem>
                                                </asp:RadioButtonList>
                                                </strong></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                                                <asp:Button ID="btnSearch" runat="server" Text="SEARCH" OnClick="btnSearch_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>
                                                <asp:Label ID="lblMas" runat="server"></asp:Label>
                                                </strong></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gdvSearch" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" OnSelectedIndexChanged="gdvSearch_SelectedIndexChanged">
                                                    <AlternatingRowStyle BackColor="#F7F7F7" />
                                                    <Columns>
                                                        <asp:ButtonField ButtonType="Button" CommandName="Select" HeaderText="Select Row" Text="-&gt;" />
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
                                    <table>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Names="impact" Font-Overline="True" Font-Size="18pt" Font-Strikeout="False" Font-Underline="True"></asp:Label>
                                            </td>
                                            <td class="auto-style7" rowspan="5">
                                                <asp:Image ID="imgCat" runat="server" Height="160px" Width="136px" Visible="False" ImageUrl="~/Admin/CatImage" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>
                                                <asp:Label ID="Label4" runat="server" Text="Category Number :"></asp:Label>
                                                </strong></td>
                                            <td>
                                                <asp:TextBox ID="txtCatNO" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>
                                                <asp:Label ID="Label8" runat="server" Text="Category Name :"></asp:Label>
                                                </strong></td>
                                            <td>
                                                <asp:TextBox ID="txtCatName" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>
                                                <asp:Label ID="Label9" runat="server" Text="Description :"></asp:Label>
                                                </strong></td>
                                            <td>
                                                <asp:TextBox ID="txtDescription" runat="server" Height="49px" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>
                                                <asp:Label ID="Label10" runat="server" Text="Category Image :"></asp:Label>
                                                </strong></td>
                                            <td>
                                                <asp:FileUpload ID="fupCatImg" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><strong>
                                                <asp:Label ID="lblMas2" runat="server" ForeColor="Red"></asp:Label>
                                                </strong></td>
                                            <td class="auto-style7">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>
                                                <asp:Button ID="btnSave" runat="server" Text="SAVE" OnClick="btnSave_Click" />
                                                &nbsp;
                                                <asp:Button ID="btnCancle" runat="server" Text="CANCEL" OnClick="btnCancle_Click" />
                                            </td>
                                            <td class="auto-style7">&nbsp;</td>
                                        </tr>
                                    </table>
                                </asp:View>
                            </asp:MultiView>
                        </asp:Panel>
                    </asp:Content>



<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">
    SqlConnection con = new SqlConnection("server=DESKTOP-J4JJ3J7\\SQLEXPRESS;database=COMPANY;integrated security=sspi");

    protected void Search()
    {
        SqlCommand cmd = new SqlCommand(string.Format("select * from member where {0} like'%{1}%'",rblSearchBy.SelectedValue,txtSearch.Text),con);
        DataTable tblCat = new DataTable();

        con.Open();
        tblCat.Load(cmd.ExecuteReader());
        con.Close();
        gdvSearch.DataSource = tblCat;
        gdvSearch.DataBind();

        gdvSearch.SelectedIndex = -1;

        btnDelMember.Enabled = false;

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Search();
    }

    protected void gdvSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        btnDelMember.Enabled = true;
    }

    protected void btnShowAll_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        Search();
    }

    protected void btnDelMember_Click(object sender, EventArgs e)
    {

        SqlCommand cmd = new SqlCommand(string.Format("delete from member where username='{0}'",gdvSearch.SelectedRow.Cells[8].Text),con);
        try {
            con.Open();
            cmd.ExecuteNonQuery();

            con.Close();

            lblMsg.Text = "Member " + gdvSearch.SelectedRow.Cells[8].Text + " is deleted";
        }
        catch(Exception ex) { lblMsg.Text = "Erorr : "+ex.Message; }
        Search();
    }

    protected void btnReportMember_Click(object sender, EventArgs e)
    {

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                        <asp:Panel ID="Panel1" runat="server">
                            <strong>
                            ً<asp:Label ID="Label2" runat="server" Text="الاعضاء" Font-Bold="True" Font-Names="impact" Font-Overline="True" Font-Size="24pt" Font-Underline="True"></asp:Label>
                            <br />
                            </strong>
                            <table align="center">
                                <tr>
                                    <td>
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
                                        <asp:Button ID="btnDelMember" runat="server" Text="حذف عضو" Enabled="False" OnClientClick="return confirmDelete();" OnClick="btnDelMember_Click" />
                                        &nbsp;
                                        <asp:Button ID="btnShowAll" runat="server" Text="عرض جميع الاعضاء" OnClick="btnShowAll_Click" />
                                        &nbsp;
                                        <asp:Button ID="btnReportMember" runat="server" Text="Report Member" OnClick="btnReportMember_Click" Visible="False" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>
                                        <asp:Label ID="Label3" runat="server" CssClass="auto-style5" Text="البحث بواسطة"></asp:Label>
                                        <asp:RadioButtonList ID="rblSearchBy" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Selected="True" Value="fullname">الاسم</asp:ListItem>
                                            <asp:ListItem Value="gender">الجنس</asp:ListItem>
                                            <asp:ListItem Value="country">المدينة</asp:ListItem>
                                        </asp:RadioButtonList>
                                        </strong></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtSearch" runat="server" Font-Names="Cairo" Font-Size="16pt"></asp:TextBox>
                                        &nbsp;
                                        <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="بحث" Font-Names="Cairo" Font-Size="16pt" Width="85px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>
                                        <asp:Label ID="lblMsg" runat="server"></asp:Label>
                                        </strong></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gdvSearch" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" OnSelectedIndexChanged="gdvSearch_SelectedIndexChanged">
                                            <AlternatingRowStyle BackColor="#F7F7F7" />
                                            <Columns>
                                                <asp:ButtonField ButtonType="Button" CommandName="Select" HeaderText="Select Row" Text="⮕" />
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
                        </asp:Panel>
                    </asp:Content>



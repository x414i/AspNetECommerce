<%@ Page Title="" Language="C#" MasterPageFile="~/Member/MemberMaster.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
   SqlConnection con = new SqlConnection("server=DESKTOP-J4JJ3J7\\SQLEXPRESS;database=COMPANY;integrated security=sspi");
    protected void Page_Load(object sender, EventArgs e)
    {
        if((Request.QueryString["catnum"]!=null)|| (Request.QueryString["pronum"]!=null))
        {
            string strCatNO = Request.QueryString["catnum"];
            string strproID = Request.QueryString["pronum"];
            SqlCommand cmd = new SqlCommand(string.Format("select * from catpro where catno={0} and proid={1}",strCatNO,strproID),con);
            DataTable tbl = new DataTable();

            con.Open();
            tbl.Load(cmd.ExecuteReader());
            con.Close();

            lblCatnum.Text = tbl.Rows[0][6].ToString();
            lblCatname.Text = tbl.Rows[0][13].ToString();
            lblProNum.Text = tbl.Rows[0][8].ToString();
            lblProName.Text = tbl.Rows[0][9].ToString();
            lblPrice.Text = tbl.Rows[0][10].ToString();
            lblAvQY.Text = tbl.Rows[0][11].ToString();
            lblWritingDate.Text = tbl.Rows[0][12].ToString();
            lblDesc.Text = tbl.Rows[0][13].ToString();
            ImgPro.ImageUrl = "..\\Admin\\ProImage\\" + strCatNO + strproID + ".jpg";


        }
        else
        {
            Response.Redirect("Categories.aspx");
        }
    }

    protected void btnAddToCart_Click(object sender, EventArgs e)
    {
        DataTable tblCarrt = new DataTable();
        if (Session["items"] != null)
            tblCarrt = (DataTable)Session["items"];
        else
        {
            tblCarrt.Columns.Add("catno");
            tblCarrt.Columns.Add("catname");
            tblCarrt.Columns.Add("proid");
            tblCarrt.Columns.Add("proname");
            tblCarrt.Columns.Add("price");
            tblCarrt.Columns.Add("qty");
            tblCarrt.Columns.Add("subtotal");
            DataColumn[] PK = { tblCarrt.Columns["catno"], tblCarrt.Columns["proid"] };
            tblCarrt.Constraints.Add("Cart_PK",PK,true);

        }
        DataRow row = tblCarrt.NewRow();
        row["catno"] = lblCatnum.Text;
        row["catname"] = lblCatname.Text;
        row["proid"] = lblProNum.Text;
        row["proname"] = lblProName.Text;
        row["price"] = lblPrice.Text;
        row["qty"] = lblAvQY.Text;
        row["subtotal"] = Convert.ToDouble(row["qty"])*Convert.ToDouble(row["price"]);
        tblCarrt.Rows.Add(row);

        Session["items"] = tblCarrt;
        Response.Redirect("Categories.aspx");




    }
   /* protected void btnAddToCart_Click(object sender, EventArgs e)
{
    DataTable tblCarrt = new DataTable();
    if (Session["items"] != null)
        tblCarrt = (DataTable)Session["items"];
    else
    {
        tblCarrt.Columns.Add("catno");
        tblCarrt.Columns.Add("catname");
        tblCarrt.Columns.Add("proid");
        tblCarrt.Columns.Add("proname");
        tblCarrt.Columns.Add("price");
        tblCarrt.Columns.Add("qty");
        tblCarrt.Columns.Add("subtotal");
        DataColumn[] PK = { tblCarrt.Columns["catno"], tblCarrt.Columns["proid"] };
        tblCarrt.Constraints.Add("Cart_PK", PK, true);
    }

    double qty, price;

   
    if (double.TryParse(txtQty.Text, out qty) && double.TryParse(lblPrice.Text, out price))
    {
        DataRow row = tblCarrt.NewRow();
        row["catno"] = lblCatnum.Text;
        row["catname"] = lblCatname.Text;
        row["proid"] = lblProNum.Text;
        row["proname"] = lblProName.Text;
        row["price"] = price;
        row["qty"] = qty;
        row["subtotal"] = qty * price;
        tblCarrt.Rows.Add(row);

        Session["items"] = tblCarrt;
        Response.Redirect("Categories.aspx");
    }
    else
    {
        lblError.Text = "Please enter valid numeric values for quantity and price.";
    }
}
*/
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style6 {
            width: 609px;
        }
        .auto-style7 {
            width: 135px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                        <asp:Panel ID="Panel1" runat="server" style="text-align: center">
                            <strong style="text-align: center">
                            &nbsp;&nbsp;&nbsp;
                            <asp:Label ID="Label2" runat="server" CssClass="auto-style1" Font-Names="cairo" Font-Overline="False" Font-Size="24pt" Font-Underline="False" Text="تفاصيل المنتج"></asp:Label>
                            &nbsp;&nbsp;
                            <br />
                            <br />
                            </strong>
                            <table align="center" class="auto-style6">
                                <tr>
                                    <td>
                                        <asp:Image ID="ImgPro" runat="server" Height="291px" Width="305px" />
                                    </td>
                                    <td>
                                        <table align="center">
                                            <tr>
                                                <td class="auto-style7">
                                                    <asp:Label ID="Label3" runat="server" ForeColor="#993399" Text="رقم الصنف" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCatnum" runat="server" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style7">
                                                    <asp:Label ID="Label4" runat="server" ForeColor="#993399" Text="اسم الصنف" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCatname" runat="server" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style7">
                                                    <asp:Label ID="Label5" runat="server" ForeColor="#993399" Text="رقم المنتج" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblProNum" runat="server" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style7">
                                                    <asp:Label ID="Label6" runat="server" ForeColor="#993399" Text="اسم المنتج" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblProName" runat="server" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style7">
                                                    <asp:Label ID="Label7" runat="server" ForeColor="#993399" Text="السعر" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPrice" runat="server" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style7">
                                                    <asp:Label ID="Label8" runat="server" ForeColor="#993399" Text="الكمية الحالية" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblAvQY" runat="server" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style7">
                                                    <asp:Label ID="Label9" runat="server" ForeColor="#993399" Text="تاريخ الاضافة" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblWritingDate" runat="server" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style7">
                                                    <asp:Label ID="Label10" runat="server" ForeColor="#993399" Text="الوصف" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDesc" runat="server" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Button ID="btnAddToCart" runat="server" OnClick="btnAddToCart_Click" Text="اضف الى السلة" Width="88px" Font-Names="Cairo" />
                                                    &nbsp;&nbsp;
                                                    <asp:TextBox ID="txtQty" runat="server" Font-Names="Cairo" Width="38px"></asp:TextBox>
                                                    <br />
                                                    <asp:Label ID="lblError" runat="server" Font-Names="Cairo" Font-Size="12pt"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </asp:Content>



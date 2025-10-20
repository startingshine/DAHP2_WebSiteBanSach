using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace DAHP2_WebSiteBanSach.pages
{
    public partial class SachMoi : System.Web.UI.UserControl
    {
        private int currentIndex
        {
            get { return ViewState["CurrentIndex"] != null ? (int)ViewState["CurrentIndex"] : 0; }
            set { ViewState["CurrentIndex"] = value; }
        }

        private DataTable dtSachMoi
        {
            get { return ViewState["SachMoiData"] as DataTable; }
            set { ViewState["SachMoiData"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSachMoi();
                BindRepeater();
            }
        }

        private void LoadSachMoi()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["QL_BanSachConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT TOP 20 * FROM Sach ORDER BY MaSach DESC", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dtSachMoi = dt;
            }
        }

        private void BindRepeater()
        {
            if (dtSachMoi == null || dtSachMoi.Rows.Count == 0)
                return;

            int start = currentIndex * 4;
            int end = Math.Min(start + 4, dtSachMoi.Rows.Count);

            DataTable dtDisplay = dtSachMoi.Clone();
            for (int i = start; i < end; i++)
                dtDisplay.ImportRow(dtSachMoi.Rows[i]);

            rptSachMoi.DataSource = dtDisplay;
            rptSachMoi.DataBind();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (dtSachMoi == null) return;

            int maxPage = (int)Math.Ceiling(dtSachMoi.Rows.Count / 4.0);
            currentIndex = (currentIndex < maxPage - 1) ? currentIndex + 1 : 0;
            BindRepeater();
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            if (dtSachMoi == null) return;

            int maxPage = (int)Math.Ceiling(dtSachMoi.Rows.Count / 4.0);
            currentIndex = (currentIndex > 0) ? currentIndex - 1 : maxPage - 1;
            BindRepeater();
        }

        protected void rptSachMoi_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ChiTiet")
            {
                string maSach = e.CommandArgument.ToString();
                Response.Redirect("~/pages/ChiTietSach.aspx?MaSach=" + maSach);
            }
        }
    }
}

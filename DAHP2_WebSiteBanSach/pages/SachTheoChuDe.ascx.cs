using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace DAHP2_WebSiteBanSach.pages
{
    public partial class SachTheoChuDe : System.Web.UI.UserControl
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTabs(); // Tải 3 chủ đề đầu tiên
                ViewState["MaChuDe"] = 1; // Chủ đề mặc định
                LoadBooks(1);
            }
        }
        // ✅ Hàm tải danh sách 3 chủ đề đầu tiên
        private void LoadTabs()
        {
            string connStr = ConfigurationManager.ConnectionStrings["QL_BanSachConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT TOP 3 MaChuDe, TenChuDe FROM ChuDe ORDER BY MaChuDe";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptTabs.DataSource = dt;
                rptTabs.DataBind();
            }
        }

        // ✅ Hàm tải 12 sách theo chủ đề
        private void LoadBooks(int maChuDe)
        {
            string connStr = ConfigurationManager.ConnectionStrings["QL_BanSachConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT TOP 12 TenSach, GiaBan, HinhAnh FROM Sach WHERE MaChuDe = @MaChuDe";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@MaChuDe", maChuDe);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptBooks.DataSource = dt;
                rptBooks.DataBind();
            }

            // Lưu lại chủ đề đang chọn để đánh dấu nút "active"
            ViewState["MaChuDe"] = maChuDe;
            LoadTabs(); // Cập nhật lại lớp CSS của tab
        }
        protected void rptTabs_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectTab")
            {
                int maChuDe = Convert.ToInt32(e.CommandArgument);
                LoadBooks(maChuDe);
            }
        }

        // ✅ Nút xem thêm → chuyển đến trang toàn bộ sách theo chủ đề
        protected void btnViewMore_Click(object sender, EventArgs e)
        {
            int maChuDe = Convert.ToInt32(ViewState["MaChuDe"]);
            Response.Redirect("DanhMuc.aspx?MaChuDe=" + maChuDe);
        }
    }
}
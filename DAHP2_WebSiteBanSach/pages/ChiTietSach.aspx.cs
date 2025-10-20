using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace DAHP2_WebSiteBanSach.pages
{
    public partial class ChiTietSach : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["QL_BanSachConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string maSach = Request.QueryString["MaSach"];
                if (!string.IsNullOrEmpty(maSach))
                {
                    LoadChiTietSach(maSach);
                }
            }
        }

        private void LoadChiTietSach(string maSach)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT s.TenSach, s.GiaBan, s.MoTa, s.HinhAnh, 
                                        tg.TenTacGia, nxb.TenNXB
                                 FROM Sach s
                                 INNER JOIN TacGia tg ON s.MaTacGia = tg.MaTacGia
                                 INNER JOIN NhaXuatBan nxb ON s.MaNXB = nxb.MaNXB
                                 WHERE s.MaSach = @MaSach";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MaSach", maSach);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblTenSach.Text = reader["TenSach"].ToString();
                    lblTacGia.Text = reader["TenTacGia"].ToString();
                    lblNXB.Text = reader["TenNXB"].ToString();
                    lblGia.Text = Convert.ToDecimal(reader["GiaBan"]).ToString("N0");
                    lblMoTa.Text = reader["MoTa"].ToString();

                    // Nếu ảnh nằm trong thư mục /images/
                    imgSach.ImageUrl = "~/images/" + reader["HinhAnh"].ToString();
                }
                reader.Close();
            }
        }

        protected void btnThemGio_Click(object sender, EventArgs e)
        {
            string maSach = Request.QueryString["MaSach"];
            if (!string.IsNullOrEmpty(maSach))
            {
                Response.Redirect("~/pages/GioHang.aspx?MaSach=" + maSach);
            }
        }
    }
}

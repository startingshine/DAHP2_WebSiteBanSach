using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DAHP2_WebSiteBanSach.pages
{
    public partial class Dangnhap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            string taiKhoan = txtTaiKhoan.Text.Trim();
            string matKhau = txtMatKhau.Text.Trim();

            string connectionString = WebConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string sql = "SELECT * FROM KhachHang WHERE TK = @TK AND MK = @MK";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@TK", taiKhoan);
                    cmd.Parameters.AddWithValue("@MK", matKhau); // Lưu ý: nên mã hóa MK thực tế

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        reader.Read();
                        // Lưu thông tin người dùng vào Session
                        Session["TK"] = reader["TK"].ToString();
                        Session["HoTen"] = reader["HoTen"].ToString();
                        Session["MaKhachHang"] = reader["MaKhachHang"].ToString();

                        // Chuyển đến trang mua hàng
                        Response.Redirect("/pages/Default.aspx");
                    }
                    else
                    {
                        lblThongBao.Text = "Sai tài khoản hoặc mật khẩu!";
                    }
                }
            }
        }
    }
}
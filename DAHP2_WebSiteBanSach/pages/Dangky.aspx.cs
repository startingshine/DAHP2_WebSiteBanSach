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
    public partial class Dangky : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            string hoTen = txtHoTen.Text.Trim();
            string email = txtEmail.Text.Trim();
            string sdt = txtSDT.Text.Trim();
            string diaChi = txtDiaChi.Text.Trim();
            string tk = txtTK.Text.Trim();
            string mk = txtMK.Text.Trim();

            string connectionString = WebConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Kiểm tra trùng tên tài khoản
                string kiemTraSQL = "SELECT COUNT(*) FROM KhachHang WHERE TK = @TK";
                using (SqlCommand cmdKT = new SqlCommand(kiemTraSQL, conn))
                {
                    cmdKT.Parameters.AddWithValue("@TK", tk);
                    int count = (int)cmdKT.ExecuteScalar();
                    if (count > 0)
                    {
                        lblThongBao.Text = "Tên tài khoản đã tồn tại. Vui lòng chọn tài khoản khác.";
                        return;
                    }
                }

                // Thêm người dùng mới
                string insertSQL = @"
                INSERT INTO KhachHang (HoTen, Email, SoDienThoai, DiaChi, TK, MK)
                VALUES (@HoTen, @Email, @SoDienThoai, @DiaChi, @TK, @MK)";

                using (SqlCommand cmd = new SqlCommand(insertSQL, conn))
                {
                    cmd.Parameters.AddWithValue("@HoTen", hoTen);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@SoDienThoai", sdt);
                    cmd.Parameters.AddWithValue("@DiaChi", diaChi);
                    cmd.Parameters.AddWithValue("@TK", tk);
                    cmd.Parameters.AddWithValue("@MK", mk); // Nên mã hóa

                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        lblThongBao.ForeColor = System.Drawing.Color.Green;
                        lblThongBao.Text = "Đăng ký thành công! Bạn có thể đăng nhập.";
                        ClearFields();
                    }
                    else
                    {
                        lblThongBao.Text = "Đăng ký thất bại. Vui lòng thử lại.";
                    }
                }
            }
        }
        private void ClearFields()
        {
            txtHoTen.Text = "";
            txtEmail.Text = "";
            txtSDT.Text = "";
            txtDiaChi.Text = "";
            txtTK.Text = "";
            txtMK.Text = "";
        }
    }
}
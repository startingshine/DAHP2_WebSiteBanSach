using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.Configuration;
using System.Web.UI.WebControls;
using System.Web;

namespace DAHP2_WebSiteBanSach.pages
{
    public partial class QuanLyDuLieu : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["QL_BanSachConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDropdownLists();
                LoadGridView();

                btnSua.CssClass = "button-disabled";
                btnXoa.CssClass = "button-disabled";
            }
        }

        private void LoadDropdownLists()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Chủ đề
                SqlCommand cmd1 = new SqlCommand("SELECT MaChuDe, TenChuDe FROM ChuDe", conn);
                ddlChuDe.DataSource = cmd1.ExecuteReader();
                ddlChuDe.DataTextField = "TenChuDe";
                ddlChuDe.DataValueField = "MaChuDe";
                ddlChuDe.DataBind();

                conn.Close(); conn.Open();

                // Tác giả
                SqlCommand cmd2 = new SqlCommand("SELECT MaTacGia, TenTacGia FROM TacGia", conn);
                ddlTacGia.DataSource = cmd2.ExecuteReader();
                ddlTacGia.DataTextField = "TenTacGia";
                ddlTacGia.DataValueField = "MaTacGia";
                ddlTacGia.DataBind();

                conn.Close(); conn.Open();

                // Nhà xuất bản
                SqlCommand cmd3 = new SqlCommand("SELECT MaNXB, TenNXB FROM NhaXuatBan", conn);
                ddlNXB.DataSource = cmd3.ExecuteReader();
                ddlNXB.DataTextField = "TenNXB";
                ddlNXB.DataValueField = "MaNXB";
                ddlNXB.DataBind();

                conn.Close();
            }
        }

        private void LoadGridView()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Sach";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    row["TenSach"] = HttpUtility.HtmlDecode(row["TenSach"].ToString());
                    row["MoTa"] = HttpUtility.HtmlDecode(row["MoTa"].ToString());
                }

                gvSach.DataSource = dt;
                gvSach.DataBind();
            }
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            string hinhAnh = UploadImage();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Sach 
                                (TenSach, GiaBan, SoLuongTon, MoTa, HinhAnh, MaChuDe, MaNXB, MaTacGia, NamXuatBan)
                                VALUES (@Ten, @Gia, @SL, @MoTa, @HinhAnh, @ChuDe, @NXB, @TacGia, @NamXB)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Ten", HttpUtility.HtmlEncode(txtTenSach.Text));
                cmd.Parameters.AddWithValue("@Gia", Convert.ToDecimal(txtGiaBan.Text));
                cmd.Parameters.AddWithValue("@SL", Convert.ToInt32(txtSoLuong.Text));
                cmd.Parameters.AddWithValue("@MoTa", HttpUtility.HtmlEncode(txtMoTa.Text));
                cmd.Parameters.AddWithValue("@HinhAnh", hinhAnh);
                cmd.Parameters.AddWithValue("@ChuDe", ddlChuDe.SelectedValue);
                cmd.Parameters.AddWithValue("@NXB", ddlNXB.SelectedValue);
                cmd.Parameters.AddWithValue("@TacGia", ddlTacGia.SelectedValue);
                cmd.Parameters.AddWithValue("@NamXB", Convert.ToInt32(txtNamXB.Text));

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadGridView();
            btnLamMoi_Click(null, null);
        }

        protected void btnSua_Click(object sender, EventArgs e)
        {
            string hinhAnh = UploadImage();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"UPDATE Sach 
                                SET TenSach=@Ten, GiaBan=@Gia, SoLuongTon=@SL, MoTa=@MoTa, 
                                    HinhAnh=@HinhAnh, MaChuDe=@ChuDe, MaNXB=@NXB, MaTacGia=@TacGia, NamXuatBan=@NamXB
                                WHERE MaSach=@Ma";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Ma", hfMaSach.Value);
                cmd.Parameters.AddWithValue("@Ten", HttpUtility.HtmlEncode(txtTenSach.Text));
                cmd.Parameters.AddWithValue("@Gia", Convert.ToDecimal(txtGiaBan.Text));
                cmd.Parameters.AddWithValue("@SL", Convert.ToInt32(txtSoLuong.Text));
                cmd.Parameters.AddWithValue("@MoTa", HttpUtility.HtmlEncode(txtMoTa.Text));
                cmd.Parameters.AddWithValue("@HinhAnh", hinhAnh);
                cmd.Parameters.AddWithValue("@ChuDe", ddlChuDe.SelectedValue);
                cmd.Parameters.AddWithValue("@NXB", ddlNXB.SelectedValue);
                cmd.Parameters.AddWithValue("@TacGia", ddlTacGia.SelectedValue);
                cmd.Parameters.AddWithValue("@NamXB", Convert.ToInt32(txtNamXB.Text));

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadGridView();
            btnLamMoi_Click(null, null);
        }

        protected void btnXoa_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Sach WHERE MaSach=@Ma", conn);
                cmd.Parameters.AddWithValue("@Ma", hfMaSach.Value);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadGridView();
            btnLamMoi_Click(null, null);
        }

        protected void gvSach_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvSach.SelectedRow;
            hfMaSach.Value = gvSach.DataKeys[row.RowIndex].Value.ToString();

            txtTenSach.Text = HttpUtility.HtmlDecode(row.Cells[2].Text);
            txtGiaBan.Text = row.Cells[3].Text.Replace(" đ", "");
            txtSoLuong.Text = row.Cells[4].Text;
            txtNamXB.Text = row.Cells[5].Text;

            // 🔹 Khi chọn sách -> hiện nút sửa và xóa
            btnSua.CssClass = "button-enabled";
            btnXoa.CssClass = "button-enabled";
        }

        protected void btnLamMoi_Click(object sender, EventArgs e)
        {
            txtTenSach.Text = txtGiaBan.Text = txtMoTa.Text = txtSoLuong.Text = txtNamXB.Text = "";
            hfMaSach.Value = "";
            imgPreview.Visible = false;

            // 🔹 Ẩn lại nút sửa và xóa
            btnSua.CssClass = "button-disabled";
            btnXoa.CssClass = "button-disabled";

            gvSach.SelectedIndex = -1;
        }

        private string UploadImage()
        {
            if (fuHinhAnh.HasFile)
            {
                string fileName = Path.GetFileName(fuHinhAnh.FileName);
                string folderPath = Server.MapPath("~/anh/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string savePath = Path.Combine(folderPath, fileName);
                fuHinhAnh.SaveAs(savePath);

                imgPreview.ImageUrl = "~/anh/" + fileName;
                imgPreview.Visible = true;
                return "anh/" + fileName;
            }
            else if (!string.IsNullOrEmpty(hfMaSach.Value))
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("SELECT HinhAnh FROM Sach WHERE MaSach=@Ma", conn);
                    cmd.Parameters.AddWithValue("@Ma", hfMaSach.Value);
                    conn.Open();
                    var result = cmd.ExecuteScalar();
                    return result != null ? result.ToString() : "anh/noimage.jpg";
                }
            }
            return "anh/noimage.jpg";
        }
    }
}

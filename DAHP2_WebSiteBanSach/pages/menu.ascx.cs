using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace DAHP2_WebSiteBanSach.pages
{
    public partial class menu : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadChuDe();
            }
        }
        void LoadChuDe()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["QL_BanSachConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT MaChuDe, TenChuDe FROM ChuDe";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptChuDe.DataSource = dt;
                rptChuDe.DataBind();
            }
        }
    }
}
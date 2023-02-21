using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;
using System.IO;

namespace proiectmulti
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        OracleConnection con;

        protected void Page_Load(object sender, EventArgs e)
        {
            string cons = "User ID = STUD_MIHAIC; Password = STUD; Data Source = (DESCRIPTION=" +
           "(ADDRESS_LIST=(ADDRESS=(PROTOCOL = TCP)(HOST = 37.120.249.41)(PORT = 1521)))" +
           "(CONNECT_DATA=(SERVER = DEDICATED)(SERVICE_NAME = orcls)));";
            con = new OracleConnection(cons);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            ErrMess.Text = "";
            if (FileUpload1.HasFile)
            {
                FileUpload1.SaveAs(@"C:\Users\Alexandra\Documents\Facultate\Master\An 1 semestrul 1\Baze de date multimedia\proiect\buchete\" + FileUpload1.FileName);
                ErrMess.Text = "Fisier incarcat " + FileUpload1.FileName;
                using (var img = System.IO.File.OpenRead(@"C:\Users\Alexandra\Documents\Facultate\Master\An 1 semestrul 1\Baze de date multimedia\proiect\buchete\" + FileUpload1.FileName))
                {
                    var imageBytes = new byte[img.Length];
                    img.Read(imageBytes, 0, (int)img.Length);
                    ErrMess.Text = "The uploaded image has " + img.Length.ToString() + " bytes.";

                    try
                    {
                        con.Open();
                    }
                    catch (OracleException ex)
                    {
                        ErrMess.Text = "Eroare" + ex.Message;
                    }
                    OracleCommand cmd = new OracleCommand("proc_ins", con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("vid", OracleDbType.Int32);
                    cmd.Parameters.Add("vdescriere", OracleDbType.Varchar2, 255);
                    cmd.Parameters.Add("fis", OracleDbType.Blob);
                    cmd.Parameters[0].Value = Convert.ToInt32(tb_id.Text);
                    cmd.Parameters[1].Value = tb_desc.Text;
                    cmd.Parameters[2].Value = imageBytes;

                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (OracleException ex)
                    {
                        ErrMess.Text = "Eroare" + ex.Message;
                    }
                    con.Close();
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            ErrMess.Text = "";
            Image1.ImageUrl = "";
            try
            {
                con.Open();
            }
            catch (OracleException ex)
            {
                ErrMess.Text = "Eroare " + ex.Message;
            }
            OracleCommand cmd = new OracleCommand("afisareimg", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("vid", OracleDbType.Int32);
            cmd.Parameters.Add("flux", OracleDbType.Blob);
            cmd.Parameters[0].Direction = ParameterDirection.Input;
            cmd.Parameters[1].Direction = ParameterDirection.Output;
            cmd.Parameters[0].Value = Convert.ToInt32(TextBox1.Text);
            try
            {
                cmd.ExecuteScalar();
                Byte[] blob = new byte[((OracleBlob)cmd.Parameters[1].Value).Length];

                try
                {
                    ((OracleBlob)cmd.Parameters[1].Value).Read(blob, 0, blob.Length);
                }
                catch (OracleException ex)
                {
                    ErrMess.Text = "Eroare " + ex.Message;
                }
                string myimg = Convert.ToBase64String(blob, 0, blob.Length);
                Image1.ImageUrl = "data:image/jpg;base64," + myimg;
            }
            catch (Exception ex)
            {
                ErrMess.Text = "Eroare " + ex.Message;
            }
        }

        protected void BulletedList1_Click(object sender, BulletedListEventArgs e)
        {

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            ErrMess.Text = "";
            try
            {
                con.Open();
            }
            catch (OracleException ex)
            {
                ErrMess.Text = ex.Message;
            }
            OracleCommand cmd = new OracleCommand("psgensemn", con);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (OracleException ex)
            {
                ErrMess.Text = ex.Message;
            }
            con.Close();
            ErrMess.Text = "Signature generated successfully!";
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            ErrMess.Text = "";
            if (FileUpload2.HasFile)
            {
                FileUpload2.SaveAs(@"C:\Users\Alexandra\Documents\Facultate\Master\An 1 semestrul 1\Baze de date multimedia\proiect\buchete\" + FileUpload2.FileName);
                using (var img = System.IO.File.OpenRead(@"C:\Users\Alexandra\Documents\Facultate\Master\An 1 semestrul 1\Baze de date multimedia\proiect\buchete\" + FileUpload2.FileName))
                {
                    Byte[] imageBytes = new byte[img.Length];
                    img.Read(imageBytes, 0, (int)img.Length);
                    try { con.Open(); }
                    catch (Exception ex)
                    {
                        ErrMess.Text = "Eroare" + ex.Message;
                    }
                    OracleCommand cmd = new OracleCommand("psregasire", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("fis", OracleDbType.Blob);
                    cmd.Parameters.Add("cculoare", OracleDbType.Decimal);
                    cmd.Parameters.Add("ctextura", OracleDbType.Decimal);
                    cmd.Parameters.Add("cforma", OracleDbType.Decimal);
                    cmd.Parameters.Add("clocatie", OracleDbType.Decimal);
                    cmd.Parameters.Add("idrez", OracleDbType.Int32);
                    for (int i = 0; i < 5; i++)
                        cmd.Parameters[i].Direction = ParameterDirection.Input;
                    cmd.Parameters[5].Direction = ParameterDirection.Output;
                    cmd.Parameters[0].Value = imageBytes;
                    cmd.Parameters[1].Value = Convert.ToDecimal(tbc_color.Text);
                    cmd.Parameters[2].Value = Convert.ToDecimal(tbc_texture.Text);
                    cmd.Parameters[3].Value = Convert.ToDecimal(tbc_shape.Text);
                    cmd.Parameters[4].Value = Convert.ToDecimal(tbc_location.Text);
                    try { cmd.ExecuteScalar(); }
                    catch (OracleException ex)
                    {
                        ErrMess.Text = "Eroare " + ex.Message;
                    }
                    tbc_idrez.Text = "";
                    tbc_idrez.Text = cmd.Parameters[5].Value.ToString();
                    con.Close();
                    if (tbc_idrez.Text == "")
                    {
                        ErrMess.Text = "Photo not processed!";
                    }
                    else
                    {
                        TextBox1.Text = tbc_idrez.Text;
                        this.Button2_Click(this, e);
                    }
                }
            }
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            ErrMess.Text = "";
            string path = Path.GetFileName(FileUpload3.FileName);
            path = path.Replace(" ", "");
            FileUpload3.SaveAs(@"C:\Users\Alexandra\Documents\Facultate\Master\An 1 semestrul 1\Baze de date multimedia\proiect\tutorial\" + FileUpload3.FileName);
            String link = "tutorial/" + path;
            Literal1.Text = "<Video width = 720 Controls><Source src=" + link + " type = video/mp4></video>";
            ErrMess.Text = "Video uploaded successfully!";
        }
    }
}
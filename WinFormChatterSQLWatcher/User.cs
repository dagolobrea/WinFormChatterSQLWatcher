using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WinFormChatterSQLWatcher.Data;

namespace WinFormChatterSQLWatcher
{
    public partial class User : Form
    {
        public int UserID
        {
            get { return (int)cboUser.SelectedValue; }
        }

        public string UserName
        {
            get { return cboUser.Text.Trim(); }
        }

        public User()
        {
            InitializeComponent();
        }

        private void User_Load(object sender, EventArgs e)
        {
            cboUser.DataSource = ChatData.GetUsers();
            cboUser.DisplayMember = "Name";
            cboUser.ValueMember = "ID";
        }
    }
}

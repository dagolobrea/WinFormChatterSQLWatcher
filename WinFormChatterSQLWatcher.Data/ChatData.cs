using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace WinFormChatterSQLWatcher.Data
{
    public class ChatData
    {
        private static string m_ConnectionString = "Data Source=SLMADTCWEB03\\TRIDIONLAB;Initial Catalog=Chatter;User ID=ChatterLogin;pwd=12345";
        private SqlConnection m_sqlConn = null;

        public delegate void NewMessage();
        public event NewMessage OnNewMessage;

        /// <summary>
        /// Constructor
        /// </summary>
        public ChatData()
        {
            // Stop an existing services on this connection string
            // just be sure
            SqlDependency.Stop(m_ConnectionString);

            // Start the dependency
            // User must have SUBSCRIBE QUERY NOTIFICATIONS permission
            // Database must also have SSB enabled
            // ALTER DATABASE Chatter SET ENABLE_BROKER
            SqlDependency.Start(m_ConnectionString);

            // Create the connection
            m_sqlConn = new SqlConnection(m_ConnectionString);
        }

        /// <summary>
        /// Destructor
        /// </summary>
        ~ChatData()
        {
            // Stop the dependency before exiting
            SqlDependency.Stop(m_ConnectionString);
        }

        /// <summary>
        /// Retreive messages from database
        /// </summary>
        /// <returns></returns>
        public DataTable GetMessages()
        {
            DataTable dt = new DataTable();

            try
            {
                // Create command
                // Command must use two part names for tables
                // SELECT <field> FROM dbo.Table rather than 
                // SELECT <field> FROM Table
                // Query also can not use *, fields must be designated
                SqlCommand cmd = new SqlCommand("usp_GetMessages", m_sqlConn);
                cmd.CommandType = CommandType.StoredProcedure;

                // Clear any existing notifications
                cmd.Notification = null;

                // Create the dependency for this command
                SqlDependency dependency = new SqlDependency(cmd);

                // Add the event handler
                dependency.OnChange += new OnChangeEventHandler(OnChange);

                // Open the connection if necessary
                if (m_sqlConn.State == ConnectionState.Closed)
                    m_sqlConn.Open();

                // Get the messages
                dt.Load(cmd.ExecuteReader(CommandBehavior.CloseConnection));
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return dt;
        }

        /// <summary>
        /// Handler for the SqlDependency OnChange event
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void OnChange(object sender, SqlNotificationEventArgs e)
        {
            SqlDependency dependency = sender as SqlDependency;

            // Notices are only a one shot deal
            // so remove the existing one so a new 
            // one can be added
            dependency.OnChange -= OnChange;

            // Fire the event
            if (OnNewMessage != null)
            {
                OnNewMessage();
            }
        }

        /// <summary>
        /// Insert a message into the database
        /// </summary>
        /// <param name="Message"></param>
        /// <param name="Person_ID"></param>
        public static void AddMessage(string Message, int Person_ID)
        {
            SqlConnection Conn = new SqlConnection(m_ConnectionString);
            SqlCommand cmd = new SqlCommand("usp_InsertMessage", Conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Message", Message);
            cmd.Parameters.AddWithValue("@Person_ID", Person_ID);

            Conn.Open();

            try
            {
                cmd.ExecuteNonQuery();
            }
            finally
            {
                Conn.Close();
            }
        }

        /// <summary>
        /// Get users from databse
        /// </summary>
        /// <returns></returns>
        public static DataTable GetUsers()
        {
            SqlConnection Conn = new SqlConnection(m_ConnectionString);
            SqlCommand cmd = new SqlCommand("SELECT ID, Name FROM dbo.Person", Conn);

            DataTable dt = new DataTable();

            Conn.Open();

            try
            {
                dt.Load(cmd.ExecuteReader());
            }
            finally
            {
                Conn.Close();
            }

            return dt;
        }
    }

}

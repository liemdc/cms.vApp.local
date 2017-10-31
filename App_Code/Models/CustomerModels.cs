using CMS.CMSHelper;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;

public class CustomerModels {
    public static List<CustomerObject> CustomerList() {        
        return LINQData.db.PM_ProjectCustomers
                .GroupJoin(LINQData.db.CMS_Users, cm => cm.ModifiedByUserId, userc => userc.UserID, (cm, userm) => new { cm, userm })
                .SelectMany(sm => sm.userm.DefaultIfEmpty(), (sm, userm) => new CustomerObject { 
                    CustomerId = sm.cm.CustomerId, CustomerName = sm.cm.CustomerName, CustomerPhone = sm.cm.CustomerPhone, CustomerEmail = sm.cm.CustomerEmail, CustomerAddress = sm.cm.CustomerAddress, UserModified = userm.FullName
                }).OrderBy(o => o.CustomerName).ToList();
    }
    public static List<CustomerObject> MinCustomerList() {        
        return LINQData.db.PM_ProjectCustomers.Select(s => new CustomerObject { 
            CustomerId = s.CustomerId, CustomerName = s.CustomerName
        }).OrderBy(o => o.CustomerName).ToList();
    }
    public static void CustomerCreated(string CustomerName, string CustomerPhone, string CustomerEmail, string CustomerAddress) {
        LINQData.db.PM_ProjectCustomers.InsertOnSubmit(new PM_ProjectCustomer() { 
            CustomerName = CustomerName, CustomerPhone = CustomerPhone, CustomerEmail = CustomerEmail, CustomerAddress = CustomerAddress, CreatedWhen = DateTime.Now, CreatedByUserId = CMSContext.CurrentUser.UserID, ModifiedWhen = DateTime.Now, ModifiedByUserId = CMSContext.CurrentUser.UserID
        });
        LINQData.db.SubmitChanges();
    }
    public static void CustomerUpdated(int CustomerId, string CustomerName, string CustomerPhone, string CustomerEmail, string CustomerAddress) {
        PM_ProjectCustomer Customer = LINQData.db.PM_ProjectCustomers.FirstOrDefault(fod => fod.CustomerId == CustomerId);
        if (Customer != null) {
            Customer.CustomerName = CustomerName;
            Customer.CustomerPhone = CustomerPhone;
            Customer.CustomerEmail = CustomerEmail;
            Customer.CustomerAddress = CustomerAddress;
            Customer.ModifiedWhen = DateTime.Now;
            Customer.ModifiedByUserId = CMSContext.CurrentUser.UserID;
            LINQData.db.SubmitChanges();
        }
    }
    public static void CustomerDeleted(int CustomerId) {
        PM_ProjectCustomer Customer = LINQData.db.PM_ProjectCustomers.FirstOrDefault(fod => fod.CustomerId == CustomerId);
        if (Customer != null) {
            LINQData.db.PM_ProjectCustomers.DeleteOnSubmit(Customer);
            LINQData.db.SubmitChanges();
        }
    }
}
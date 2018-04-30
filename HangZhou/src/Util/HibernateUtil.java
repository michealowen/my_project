package Util;

import org.hibernate.Session;  
import org.hibernate.SessionFactory;  
import org.hibernate.Transaction;  
import org.hibernate.cfg.Configuration;  
  
public final class HibernateUtil {  
    private static SessionFactory sessionFactory;  
      
    private HibernateUtil(){  
    }  
      
    static{  
        Configuration cfg = new Configuration();  
        cfg.configure();  
        sessionFactory = cfg.buildSessionFactory();  
    }  
      
    public static SessionFactory getSessionFactory(){  
        return sessionFactory;  
    }  
    public static Session getSession(){  
        return sessionFactory.openSession();  
    }  
}  
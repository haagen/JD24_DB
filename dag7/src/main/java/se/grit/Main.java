package se.grit;

import org.hibernate.Session;

public class Main {

    private static void example_1() {
        Session session = HibernateUtil
                .getSessionFactory()
                .openSession();

        Contacts c = new Contacts();
        c.setName("Paddington");
        c.setEmail("paddington@finance.gov.uk");
        c.setAccountsId(1);

        session.beginTransaction();
        session.persist(c);
        session.getTransaction().commit();

        HibernateUtil.shutdown();
    }

    public static void main(String[] args) {
        example_1();
    }
}
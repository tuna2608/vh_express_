/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.config.DBContext;
import model.entity.Cars;
import model.entity.Users;

/**
 *
 * @author tuna
 */
public class CarRepository {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public ArrayList<Cars> getListCars() {
        ArrayList<Cars> list = new ArrayList<>();
        String sql = "SELECT * FROM cars";

        try {
            con = (Connection) new DBContext().getConnection();
            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();
            while (rs.next()) {
                int idcar = rs.getInt(1);
                String namecar = rs.getString(2);
                String type = rs.getString(3);
                int countseat = rs.getInt(4);
                int isactive = rs.getInt(5);
                String licenseplate = rs.getString(6);
                Cars car = new Cars(idcar, namecar, type, countseat, isactive, licenseplate);
                list.add(car);
            }
            return list;
        } catch (Exception e) {
            System.err.println(e);
            System.out.println("Lỗi list trong car repo");
        }
        return null;
    }

    public String InserCar(Cars c) {
        String sql = "INSERT INTO cars (name, type, countseat, isactive, licenseplate)\n"
                + "VALUES\n"
                + "    (?, ?, ?, 1, ?)";

        try {
            con = (Connection) new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            String name = c.getName();
            String type = c.getType();
            int countseat = c.getCountseat();
            String licenseplate = c.getLicenseplate();

            ps.setString(1, name);
            ps.setString(2, type);
            ps.setInt(3, countseat);
            ps.setString(4, licenseplate);
            
            int i = ps.executeUpdate();
            if(i!=0){
                return "SUCCESS";
            }
            
            ps.close();

        } catch (Exception e) {
            System.err.println("RegisterRepository File:: " + e);
        }
        return "ERROR";
    }
    
    
    public Cars getCar(int id) {
        Cars c = new Cars();
        String sql = "SELECT * FROM cars WHERE id = ?";

        try {
            con = (Connection) new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();
            if (rs.next()) {
                return new Cars(rs.getInt("id"),rs.getString("name"),rs.getString("type"),rs.getInt("countseat"),rs.getInt("isactive"),rs.getString("licenseplate"));
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("khong lay dc id");
        }
        return c;
    }
    
    public Cars getCarbyLicenseplate(String licenseplate) {
        Cars c = new Cars();
        String sql = "SELECT * FROM cars WHERE licenseplate = ?";

        try {
            con = (Connection) new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, licenseplate);

            rs = ps.executeQuery();
            if (rs.next()) {
                return new Cars(rs.getInt("id"),rs.getString("name"),rs.getString("type"),rs.getInt("countseat"),rs.getInt("isactive"),rs.getString("licenseplate"));
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("khong lay dc licenseplate");
        }
        return c;
    }
    
    public static void main(String[] args) {
        CarRepository cr = new CarRepository();
//        System.out.println(cr.getListCars());
        
        String name = new String("Hoa Hieu");
        String type = new String("VIP");
        int countseat = 40;
        String licenseplate = new String("73A16699");
        String id  = new String("1");
        Cars car = new Cars(name, type, countseat, licenseplate);
//        cr.InserCar(car);
//        Cars c = cr.getCar(id);
//        System.out.println(c);
//        System.out.println(cr.insertSeats(1, 1));
        System.out.println(cr.getCarbyLicenseplate(licenseplate));
    }
}

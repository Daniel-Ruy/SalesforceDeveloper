public with sharing class ParkLocator {

    public static List< String> country(String countryName){
        ParkService parkService = new ParkService();
        return parkService.getCountry(countryName);

    }

}
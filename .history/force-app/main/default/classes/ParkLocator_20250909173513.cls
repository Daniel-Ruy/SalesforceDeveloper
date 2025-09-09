public with sharing class ParkLocator {

    public static List< String> country(String countryName){
        ParkService.ParksImplPort port = new ParkService.ParksImplPort();
        port.byCountry(countryName);

    }

}
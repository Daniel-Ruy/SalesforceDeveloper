@isTest
public with sharing class AnimalLocatorTest {
  @isTest
  Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
  Test.startTest();
  String animalName = AnimalLocator.getAnimalNameById(1);
  Test.stopTest();

}
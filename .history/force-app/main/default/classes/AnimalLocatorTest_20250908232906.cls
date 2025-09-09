@isTest
public with sharing class AnimalLocatorTest {
  Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
  test.start();
  AnimalLocator locator = new AnimalLocator();
  String animalName = locator.getAnimalNameById(1);
  System.Assert.areEqual('Dog', animalName);

}
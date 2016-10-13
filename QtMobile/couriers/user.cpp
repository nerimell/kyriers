#include "user.h"

using namespace std;

int User::getId() {
    return id;
}

int User::getCity() {
    return city;
}

int User::getStatus() {
    return status;
}

string User::getPin() {
    return pin;
}

string User::getSsid(){
    return ssid;
}

string User::getNumber() {
    return number;
}

string User::getMail(){
    return mail;
}

void User::setId(int usid) {
    this->id = usid;
}

string User::getUserName() {
    return userName;
}

string User::getLastName() {
    return lastName;
}

string User::getResponse() {
    return response;
}

string User::getPassword() {
    return password;
}

void User::setCity(int city) {
    this->city = city;
}

void User::setPin(string pin) {
    this->pin = pin;
}

void User::setSsid(string ssid) {
    this->ssid = ssid;
}

void User::setMail(string email) {
    this->mail = email;
}

void User::setStatus(int status) {
    this->status = status;
}

void User::setNumber(string number) {
    this->number = number;
}

void User::setUserName(string userName) {
    this->userName = userName;
}

void User::setLastName(string lastName) {
    this->lastName = lastName;
}

void User::setPassword(string password) {
    this->password = password;
}

void User::setResponse(string response) {
    this->response=response;
}

User::User()
{

}

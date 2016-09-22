#include "user.h"

using namespace std;

int User::getId() {
    return id;
}

string User::getPin() {
    return pin;
}

string User::getSsid(){
    return ssid;
}

int User::getNumber() {
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

string User::getResponse() {
    return response;
}

string User::getPassword() {
    return password;
}

void User::setPin(string pin) {
    this->pin = pin;
}

void User::setMail(string email) {
    this->mail = email;
}

void User::setSsid(string ssid) {
    this->ssid = ssid;
}

void User::setNumber(int number) {
    this->number = number;
}

void User::setUserName(string userName) {
    this->userName = userName;
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

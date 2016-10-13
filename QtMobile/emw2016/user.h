#ifndef USER_H
#define USER_H
#include <iostream>

using namespace std;

class User
{
private:
    int id;
    int city;
    int status;

    string mail;
    string number;
    string pin = "";
    string ssid= "";
    string userName;
    string lastName;
    string password;
    string response;

public:
    User();

    int getId();

    int getCity();

    int getStatus();

    void setId(int);

    string getPin();

    string getSsid();

    string getMail();

    void setCity(int);

    string getNumber();

    void setStatus(int);

    void setPin(string);

    void setNumber(string);

    string getResponse();

    string getUserName();

    string getLastName();

    string getPassword();

    void setMail(string);

    void setSsid(string);

    void setPassword(string);

    void setUserName(string);

    void setLastName(string);

    void setResponse(string);
};

#endif // USER_H

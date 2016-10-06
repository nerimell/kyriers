#ifndef USER_H
#define USER_H
#include <iostream>

using namespace std;

class User
{
private:
    int id;

    string pin = "";
    string mail;
    string number;
    string ssid= "";
    string userName;
    string lastName;
    string password;
    string response;

public:
    User();

    int getId();

    void setId(int);

    string getPin();

    string getNumber();

    string getSsid();

    string getMail();

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

#ifndef USER_H
#define USER_H
#include <iostream>

using namespace std;

class User
{
private:
    int id;
    int number;

    string pin;
    string mail;
    string ssid= "";
    string userName;
    string password;
    string response;

public:
    User();

    int getId();

    void setId(int);

    string getPin();

    int getNumber();

    string getSsid();

    string getMail();

    void setPin(string);

    void setNumber(int);

    string getResponse();

    string getUserName();

    string getPassword();

    void setMail(string);

    void setSsid(string);

    void setPassword(string);

    void setUserName(string);

    void setResponse(string);
};

#endif // USER_H

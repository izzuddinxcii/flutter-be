
# Freelancer App

Is a mobile app using Flutter as its hybrid and easy to publish on Apple App Store and Google Play Store.

Tested on iOS and Android.


## Documentation

This app only consist three screen.

- List of User
- Search User
- Update / New User

What we have on every screen.

### List of Users

![Screenshot](https://i.postimg.cc/HsrtGnC4/Simulator-Screen-Shot-i-Phone-14-2022-12-06-at-10-21-01.png)

This screen will have all user with all the data.

User avatar source pulled from Gravatar.

To refresh for new data, just pull down the page. Red trashbin button on upper right will detele the user.

#### Roadmap

- Click to Call / Email

- Only Admin can do Delete / User only can see

### Search Users

![Screenshot](https://i.postimg.cc/rswLJbzj/Simulator-Screen-Shot-i-Phone-14-2022-12-06-at-10-25-45.png)

Reused same data as in the List of Users.

Search will query from all user data (username, email, phone number, skill sets and hobby).

#### Roadmap

- Search on spesific field

### Update / New User

![Screenshot](https://i.postimg.cc/Y0HxBKQN/Simulator-Screen-Shot-i-Phone-14-2022-12-06-at-10-29-10.png)

Create / update user info.

#### Roadmap

- Add more Skill Sets
- Autocomplete user type hobby
## Run Locally

Clone the project

```bash
  git clone https://github.com/izzuddinxcii/flutter-be.git
```

Go to the project directory

```bash
  cd flutter-be
```

Install dependencies

```bash
  flutter pub get
```

Start the server

```bash
  flutter run
```
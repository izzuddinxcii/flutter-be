
# Freelancer App

This mobile app is developed using Flutter as its hybrid and easy to publish on Apple App Store and Google Play Store.

Tested on iOS and Android.


## Documentation

This app only consists of three screens.

- List of User
- Search User
- Update / New User

What we have on every screen.

### List of Users

![Screenshot](https://i.postimg.cc/HsrtGnC4/Simulator-Screen-Shot-i-Phone-14-2022-12-06-at-10-21-01.png)

This screen will have all users with all the data.

User avatar source pulled from Gravatar.

To refresh for new data, just pull down the page. The red trashbin button on the upper right will delete the user.

#### Roadmap

- Click to Call / Email

- Only Admin can do Delete / User only can see

### Search Users

![Screenshot](https://i.postimg.cc/rswLJbzj/Simulator-Screen-Shot-i-Phone-14-2022-12-06-at-10-25-45.png)

Reused the same data as in the List of Users.

Search will query from all user data (username, email, phone number, skill sets and hobby).

#### Roadmap

- Search on specific field

### Update / New User

![Screenshot](https://i.postimg.cc/Y0HxBKQN/Simulator-Screen-Shot-i-Phone-14-2022-12-06-at-10-29-10.png)

Create/update user info.

#### Roadmap

- Add more Skill Sets
- Autocomplete hobby input
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
  npm install
```

Start the server

```bash
  npm run start
```
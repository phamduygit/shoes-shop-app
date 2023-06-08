class AuthValidate {
  dynamic validateSignInForm(String email, String password) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    final bool passwordValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(password);
    if (!emailValid) {
      return {
        'subject': 'Invalid email',
        'message': 'Please enter valid email'
      };
    }

    if (!passwordValid) {
      // return {'subject': 'Invalid password', 'message': 'Password must contain least one upper case, one digit, one special character and 8 characters in length'};
      return null;
    }

    return null;
  }

  dynamic validateSignUpForm(
      String name, String email, String password, String confirmPassword) {
    var validtaeEmailPasswordResult = validateSignInForm(email, password);

    if (name.isEmpty) {
      return {
        'subject': 'Invalid name',
        'message': 'Name must not be blank',
      };
    }

    if (validtaeEmailPasswordResult != null) {
      return validtaeEmailPasswordResult;
    }

    if (confirmPassword != password) {
      return {
        'subject': 'Invalid password',
        'message': "Confirm password doesn't match with password"
      };
      
    }
  }
}

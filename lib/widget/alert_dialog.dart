import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:admin/globals.dart';

enum DialogsAction { yes, cancel }
enum OkayDialogsAction { okay }
var priceController = TextEditingController();
var discountController = TextEditingController();
var fullnameController = TextEditingController();
var discountIDController = TextEditingController();
var emailController = TextEditingController();
List discountCategory = ['Student', 'PWD', 'Senior Citizen'];

var minBagController = TextEditingController();
var maxBagController = TextEditingController();
var pesoPerBagController = TextEditingController();

class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String body,
    String title,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.cancel),
                child: const Text('Cancel'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                child: const Text('Add'),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> OriginFieldDialog(
    BuildContext context,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: TextField(
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Enter Origin"),
              onChanged: (value) {
                addNewOrigin = value;
              },
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.cancel),
                child: const Text('Cancel'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                child: const Text('Add'),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> BusClassFieldDialog(
    BuildContext context,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: TextField(
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Enter Bus Class"),
              onChanged: (value) {
                addNewBusClass = value;
              },
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.cancel),
                child: const Text('Cancel'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                child: const Text('Add'),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> DestinationFieldDialog(
    BuildContext context,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: TextField(
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Enter Destination"),
              onChanged: (value) {
                addAddNewDestination = value;
              },
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.cancel),
                child: const Text('Cancel'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                child: const Text('Add'),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<bool> ErroralertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(children: [
              Icon(
                Icons.error,
                color: errorColor,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text('ERROR!', style: TextStyle(color: errorColor)),
            ]),
            content: Text('Check all fields'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Okay'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  static Future<bool> errorUsernameExist(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(children: [
              Icon(
                Icons.error,
                color: errorColor,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text('ERROR!', style: TextStyle(color: errorColor)),
            ]),
            content: Text('Username Already Exist'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Okay'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  static Future<bool> errorEmailExist(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(children: [
              Icon(
                Icons.error,
                color: errorColor,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text('ERROR!', style: TextStyle(color: errorColor)),
            ]),
            content: Text('Email Already Exist'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Okay'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  static Future<bool> errorUserandEmail(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(children: [
              Icon(
                Icons.error,
                color: errorColor,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text('ERROR!', style: TextStyle(color: errorColor)),
            ]),
            content: Text('Email and User already Exist'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Okay'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  static Future<bool> errorAddAccount(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(children: [
              Icon(
                Icons.error,
                color: errorColor,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text('ERROR!', style: TextStyle(color: errorColor)),
            ]),
            content: Text('Complete all fields'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Okay'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  static Future<bool> errorDate(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(children: [
              Icon(
                Icons.error,
                color: errorColor,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text('ERROR!', style: TextStyle(color: errorColor)),
            ]),
            content: Text('Some dates are not available'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Okay'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  static Future<bool> errorAddBus(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(children: [
              Icon(
                Icons.error,
                color: errorColor,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text('ERROR!', style: TextStyle(color: errorColor)),
            ]),
            content: Text('Bus is already Existing'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Okay'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  static Future<bool> errorAddTrip(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(children: [
              Icon(
                Icons.error,
                color: errorColor,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text('ERROR!', style: TextStyle(color: errorColor)),
            ]),
            content: Text('Some Trips Already Exist'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Okay'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  static Future<DialogsAction> successDialog(
    BuildContext context,
    String body,
    String title,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Color.fromRGBO(24, 168, 30, 1.0),
                  size: 24.0,
                  semanticLabel: '',
                ),
                Text(title),
              ],
            ),
            content: Text(body),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> errorDialog(
    BuildContext context,
    String body,
    String title,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24.0,
                  semanticLabel: '',
                ),
                Text(title),
              ],
            ),
            content: Text(body),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> forgotPasswordFieldDialog(
    BuildContext context,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: TextField(
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Enter your Email"),
              onChanged: (value) {
                ForgotPass = value;
              },
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.cancel),
                child: const Text('Cancel'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                child: const Text('Send'),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> loginFailed(
    BuildContext context,
    String body,
    String title,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 24.0,
                  semanticLabel: '',
                ),
                Text(title),
              ],
            ),
            content: Text(body),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> sureDialog(
    BuildContext context,
    String body,
    String title,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.cancel),
                child: const Text('Cancel'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                child: const Text('Yes'),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> priceCategoryDialog(
    BuildContext context,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Price Category"),
                SizedBox(height: defaultPadding),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter category name",
                  ),
                  controller: priceController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter a category name";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    addNewPriceCategory = value;
                  },
                ),
                SizedBox(height: defaultPadding),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter discount by percentage",
                  ),
                  controller: discountController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter a discount";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    addNewPriceDiscount = value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.cancel),
                child: const Text('Cancel'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                child: const Text('Add'),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> discountIDCategoryDialog(
    BuildContext context,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Apply for Discount"),
                SizedBox(height: defaultPadding),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Full Name",
                  ),
                  controller: fullnameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter full name";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    discountIDFullName = value;
                  },
                ),
                SizedBox(height: defaultPadding),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Valid Email",
                  ),
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    discountIDEmail = value;
                  },
                ),
                SizedBox(height: defaultPadding),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Discount ID",
                  ),
                  controller: discountIDController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter your discount ID";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    discountID = value;
                  },
                ),
                SizedBox(height: defaultPadding),
                DropdownButtonFormField(
                  hint: Text("Select Category"),
                  onChanged: (value) {
                    selectedDiscountIDCategory = value;
                  },
                  items: discountCategory.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.cancel),
                child: const Text('Cancel'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                child: const Text('Add'),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }

  static Future<DialogsAction> baggageFieldDialog(
    BuildContext context,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Baggage Limit"),
                SizedBox(height: defaultPadding),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Minimum Baggage in Kilograms",
                  ),
                  controller: minBagController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter valid minimum baggage";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    minimumBaggage = value;
                  },
                ),
                SizedBox(height: defaultPadding),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Maximum Baggage in Kilograms",
                  ),
                  controller: maxBagController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter a valid maximum baggage";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    maximumBaggage = value;
                  },
                ),
                SizedBox(height: defaultPadding),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Amount per 0.1kg extra",
                  ),
                  controller: pesoPerBagController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String value) {
                    if (value.contains(RegExp(r'[A-Z]'))) {
                      return "Please enter a valid amount";
                    } else if (value.contains(RegExp(r'[a-z]'))) {
                      return "Please enter a valid amount";
                    } else if (value.isEmpty) {
                      return "Please enter a valid amount";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    pesoPerBaggage = value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.cancel),
                child: const Text('Cancel'),
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(DialogsAction.yes);
                  minBagController.clear();
                  maxBagController.clear();
                  pesoPerBagController.clear();
                },
                child: const Text('Add'),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }
}

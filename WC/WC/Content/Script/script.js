function hrefLink(sender) {
    var listTab = ["#tab1", "#tab2", "#tab3"];
    var currentAttrValue = sender.getAttribute("href");

    for (var i = 0; i < listTab.length; i++) {
        if (currentAttrValue != listTab[i]) {
            $(listTab[i]).removeClass('active');
        } else {
            $(listTab[i]).addClass('active');
        }
    }
}

function validateEmail(email) {
    var re = /\S+@\S+\.\S+/;
    return re.test(email);
}

/*Validation Form*/
function onValidateEmail(sender, parentName) {
    var email = sender.value;
    onValidateText(sender, parentName);

    if (!validateEmail(email)) {
        $("#" + parentName).css('border', '1px solid red');
        $("#" + parentName).removeClass('passed');
        $("#" + parentName).addClass('required');
    } else {
        $("#" + parentName).css('border', '1px solid #efefef');
        $("#" + parentName).removeClass('required');
        $("#" + parentName).addClass('passed');
    }
}
function onValidateText(sender, parentName) {
    var text = sender.value;

    if (text.length != 0) {
        $("#" + parentName).css('border', '1px solid #efefef');
        $("#" + parentName).removeClass('required');
        $("#" + parentName).addClass('passed');
    } else {
        $("#" + parentName).css('border', '1px solid red');
        $("#" + parentName).removeClass('passed');
        $("#" + parentName).addClass('required');
    }
}

//Login
function onValidateLoginForm() {
    var result = true;
    var f = document.forms["login-form"];

    if (f.lg_email.value.length == 0) {
        $("#vlg_email").css('border', '1px solid red');
        result = false;
    }

    if (f.lg_password.value.length == 0) {
        $("#vlg_password").css('border', '1px solid red');
        result = false;
    }
    return result;
}
function onLogin() {
    $("#lg_loading").show();
    var valid = onValidateLoginForm();
    if (valid) {
        var f = document.forms["login-form"];
        var remember = f.lg_remember.checked;
        var email = f.lg_email.value;
        var password = f.lg_password.value;
        //TO DO
        alert(email + " - " + password + " - " + remember);
    }
    $("#lg_loading").hide(); 
    return;
}

//Registration
function onValidateRegistrationForm() {
    var result = true;
    var f = document.forms["register-form"];

    if (f.r_firstname.value.length == 0) {
        $("#vr_firstname").css('border', '1px solid red');
        result = false;
    }

    if (f.r_lastname.value.length == 0) {
        $("#vr_lastname").css('border', '1px solid red');
        result = false;
    }

    if (f.r_email.value.length == 0) {
        $("#vr_email").css('border', '1px solid red');
        result = false;
    }

    if (f.r_password.value.length == 0) {
        $("#vr_password").css('border', '1px solid red');
        result = false;
    }

    if (!f.r_agree.checked) {
        $("#r_agree_msg").text("***");
        $("#r_agree_msg").css('color', 'red');
        result = false;
    } else {
        $("#r_agree_msg").text("✔");
        $("#r_agree_msg").css('color', '#4caf50');
    }

    return result;
}

function onRegistration() {
    $("#r_loading").show();
    var valid = onValidateRegistrationForm();
    if (valid) {
        var f = document.forms["register-form"];
        var firstname = f.r_firstname.value;
        var lastname = f.r_lastname.value;
        var email = f.r_email.value;
        var password = f.r_password.value;
        //TO DO
        alert(email + " - " + password + " - " + firstname + " - " + lastname);
    }
    $("#r_loading").hide();
    return;
}

//ForgotPassword
function onValidateForgotPasswordForm() {
    var result = true;
    var f = document.forms["forgotpassword-form"];

    if (f.fg_email.value.length == 0) {
        $("#vfg_email").css('border', '1px solid red');
        result = false;
    }
    return result;
}

function onForgotPassword() {
    $("#fg_loading").show();
    var valid = onValidateForgotPasswordForm();
    if (valid) {
        var f = document.forms["forgotpassword-form"];
        var email = f.fg_email.value;
        //TO DO
        alert(email);
    }
    $("#fg_loading").hide();
    return;
}
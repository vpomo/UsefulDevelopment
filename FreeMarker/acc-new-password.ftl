<head>
    <script type="text/javascript" src="/res_v4.0/js/jquery-1.9.1.min.js"></script>
    <script src="${base}/res_v4.0/js/jquery.validation.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${base}/res_v4.0/js/layer/layer.js"></script>
    <link rel="stylesheet" href="${base}/res_v4.0/css/my_cabinet.css"/>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Смена пароля</title>
</head>
<style>
    label.error {
        color: red;
        font-style: italic;
    }

    input.error {
        border: 1px dotted #f00;
    }

    * {
        font-family: Arial
    }
</style>
<body>
<#assign siteSettingTag = newTag("siteSettingTag") />
<#assign siteSet = siteSettingTag("") />

<script>
    var SITEURL = "${base}";
</script>
<form method="post" name="theForm" id="theForm" action="">
    <input type="hidden" name="memberId" id="memberId" value="${member.memberId}">

    <table style="font-family:PT Sans Narrow;" width="400" border="0">

        <tr>
            <td colspan="2" style=" text-align:center; font-size:18px;">
                <p style="margin-top:16px; margin-bottom:16px; margin-right:-80px;">
                    Для смены текущего пароля, пожалуйста,<br/>
                    повторите ввод нового пароля<br/>
                    два раза и нажмите "Сменить пароль".
                </p>
            </td>
        </tr>
        <div class="1line_form_password"></div>

        <tr <#if (RequestParameters.p) > style="display:none"</#if> >
            <td colspan="2"><span id="sdfsdf44"
                                  style="font-size:18px; margin-left:140px; ">ВВЕДИТЕ СТАРЫЙ ПАРОЛЬ:</span> <span
                    class="mobile-error" style="margin-left: 20px;color:#c4000;color:red;"></span><br/>
                <input style=" font-size:18px; color:#555; text-align:left; border-style:solid;
            border-width:thin;border-color:#555 #555 #555 #555; margin-bottom:20px;
            width:320px; font-family:Arial; margin-left:140px;"
                       name="oldPasswd" type="password"  <#if (RequestParameters.p) > value="333333"</#if> id="oldPasswd" height="24" maxlength="12"/>
                <span class="goods-z ml"> </span>
            </td>
        </tr>
        <tr>
            <td colspan="2"><span id="sdfsdf44" style="font-size:18px; margin-left:140px; ">ВВЕДИТЕ НОВЫЙ ПАРОЛЬ:</span>
                <span
                        class="mobile-error" style="margin-left: 20px;color:#c4000;color:red;"></span><br/>
                <input style=" font-size:18px; color:#555; text-align:left; border-style:solid;
            border-width:thin;border-color:#555 #555 #555 #555; margin-bottom:20px;
            width:320px; font-family:Arial; margin-left:140px;"
                       name="newPasswd" type="password" id="newPasswd" height="24" maxlength="12"/>
                <span class="goods-z ml"> </span>
            </td>
        </tr>
        <tr>
            <td colspan="2"><span id="sdfsdf44"
                                  style="font-size:18px; margin-left:140px; ">ПОДТВЕРДИТЕ НОВЫЙ ПАРОЛЬ:</span>
                <span
                        class="mobile-error" style="margin-left: 20px;color:#c4000;color:red;"></span><br/>
                <input style=" font-size:18px; color:#555; text-align:left; border-style:solid;
            border-width:thin;border-color:#555 #555 #555 #555; margin-bottom:20px;
            width:320px; font-family:Arial; margin-left:140px;"
                       name="newPasswd2" type="password" id="newPasswd2" height="24" maxlength="12"/>
                <span class="goods-z ml"> </span>
            </td>
        </tr>

        <tr>
            <td colspan="2" style="text-align:center;"></td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2" align="center">
            </td>
        </tr>

    </table>
    <div class="1line_form_password"></div>

    <p align="center">
        <input style="background:#000; width:210px; height:40px; font-size:18px; color:#FFF;
      font-family:Arial; border-width:0px;" type="submit" onclick="updatePassword();" name="submit" id="se4rfs33"
               value="СОХРАНИТЬ"/>
    </p>
</form>
</body>
</html>
<script>

    $("#theForm").validate({
        errorPlacement: function (error, element) {
            $(element).next('.field_notice').hide();
            $(element).after(error);
        },
        rules: {
            oldPasswd: {
                required: true,
                minlength: 6,
                maxlength: 20
            },
            newPasswd: {
                required: true,
                minlength: 6,
                maxlength: 20
            },
            newPasswd2: {
                required: true,
                minlength: 6,
                maxlength: 20,
                equalTo: "#newPasswd"
            },
        },
        messages: {
            oldPasswd: {
                required: 'Существующий пароль не может быть пустым',
                maxlength: 'Длина пароля от 6 до 20 символов',
                minlength: 'Минимальная длина должна быть 6 символов'
            },
            newPasswd: {
                required: 'Новый пароль не может быть пустым',
                maxlength: 'Длина пароля от 6 до 20 символов',
                minlength: 'Минимальная длина должна быть 6 символов'
            },
            newPasswd2: {
                required: 'Повторите ввод нового пароля',
                maxlength: 'Длина пароля от 6 до 20 символов',
                minlength: 'Минимальная длина должна быть 6 символов',
                equalTo: 'Введенные пароли не совпадают'
            }
        }
    });

    function returnOK(messageOK) {
        parent.layer.closeAll();
    }
    function quxiao() {
        //$.cookie("password","");
        parent.layer.closeAll();	
		//parent.location.href='/user/setting/index';
    }

    function updatePassword() {
        if ($('#theForm').valid()) {
            $.ajax({
                url: '${base}/forget/updatePass',
                dataType: 'json',
                type: 'post',
                data: $("#theForm").serialize(),
                async: false,
                success: function (data) {
                    if (data.success == 'true') {
                        parent.layer.msg('Пароль успешно изменен', {icon: 1}, quxiao());						parent.location.href='/user/setting/index';
                    } else {
                        parent.layer.msg(data.message, {icon: 2}, quxiao());
                    }
                }, error: function (data) {
                    parent.layer.msg('Старый пароль указан неверно!', {icon: 2}, quxiao());
                }
            });
        }
    }

</script>
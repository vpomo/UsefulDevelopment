<head>
    <script type="text/javascript" src="/res_v4.0/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${base}/res_v4.0/js/layer/layer.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Проверка отправленного в СМС кода</title>
</head>
<style>
    .buttonConfirm{
        margin:30px 0;
        color:white;
        width:228px;
        height: 35px;
        background: black;
        border: none;
        outline: none;
        font-family: MuseoSansBold;
        font-size: 18px;
        cursor:pointer;
    }
    .buttonConfirm:hover{
        background:	#62db96;
        color:white;
    }
    .textInputCodeSms{
        position: relative;
        margin: 0px 0px 0px 190px;
        font-size: 10pt;
        font-family: MuseoSansLight;
        color: black;
    }
    .valueInputCodeSms{
        font-size:18px;
        color:#555;
        text-align:left;
        border-style:solid;
        border-width:thin;
        border-color:#555 #555 #555 #555;
        margin-bottom:20px;
        width:140px;
        font-family:Arial;
        margin: 5px 0px 0px 192px;
    }
</style>
<body>
<form id="sms" target="_parent" action="" method="post">
    <input id="codeSms" value="${codeSms}" type="hidden"/>
    <br><br>
    <p class="textInputCodeSms">ВВЕДИТЕ КОД ИЗ СМС</p>
    <input class="valueInputCodeSms" name="myCodeSms" type="text" id="myCodeSms" height="35" maxlength="6"/>
    <p align="center">
        <input class="buttonConfirm" type="submit" onclick="checkCodeSms();" name="submit" id="se4rfs33"
               value="ПОДТВЕРДИТЬ"/>
    </p>

</form>
<script>

    function checkCodeSms() {
        if ($("#myCodeSms").val() == $("#codeSms").val()) {
            window.parent.$("#legalSms").val("1");
            parent.layer.msg('Подлинность подтверждена !', false, 999999, quxiao());
        } else {
            parent.layer.msg('Несовпадение введенного кода с отправленным по СМС !', false, 999999, quxiao());
        }
    }

    function quxiao() {
        parent.layer.closeAll();
    }

</script>

</body>

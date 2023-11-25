var Helper = /** @class */ (function () {
    function Helper() {
    }
    Helper.updateQueryStringParameter = function (uri, key, value) {
        var re = new RegExp("([?|&])" + key + "=.*?(&|$)", "i");
        var separator = uri.indexOf('?') !== -1 ? "&" : "?";
        if (uri.match(re)) {
            return uri.replace(re, '$1' + key + "=" + value + '$2');
        }
        else {
            return uri + separator + key + "=" + value;
        }
    };
    //static getURLParameter(name: string): string {
    //    var p = RegExp(name + '=' + '(.+?)(&|$)').exec(location.search);
    //    return decodeURI(
    //        (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search) || [, null])[1]
    //        );
    //}
    Helper.showMessage = function (message, messageAreaId) {
        if (messageAreaId === void 0) { messageAreaId = "messageArea"; }
        $("#" + messageAreaId).html(message).dialog({
            autoOpen: true,
            show: 'fade',
            hide: 'fade',
            buttons: {
                "OK": function () {
                    $(this).dialog("close");
                }
            },
            width: 380
        });
    };
    Helper.showInPopup = function (url, x, y, width, height, title, imageUrl, popupDivId, dlgClass) {
        var originalContent;
        originalContent = $("#" + popupDivId).html();
        $("#" + popupDivId).append('<img class="wait" src="' + imageUrl + '"/>');
        $("#" + popupDivId).dialog({
            title: title,
            position: [x, y],
            width: width,
            height: height,
            dialogClass: dlgClass,
            close: function (event, ui) {
                $("#" + popupDivId).html(originalContent);
            }
        });
        $.get(url, function (data) {
            $("#" + popupDivId).html(data);
        });
    };
    ///for a given id and a button with name imagebutton_{id} and content_{id} it will hide and show the content when the user clicks the button
    Helper.popupContent = function (Id, title) {
        var ButtonId = "imagebutton_" + Id;
        var ContentId = "content_" + Id;
        var x = $("#" + ButtonId).offset().left + $("#" + ButtonId).width();
        var y = $("#" + ButtonId).offset().top + $("#" + ButtonId).height();
        var clone = $("#" + ContentId).clone();
        clone.addClass("popup");
        clone.attr("id", "clone_" + Id);
        var CloneId = "clone_" + Id;
        if (($("#" + CloneId).dialog('isOpen')) === true) {
            $("#" + CloneId).remove();
        }
        else {
            clone.dialog({
                show: 'slide',
                hide: 'slide',
                title: title,
                position: [x, y],
                width: 600,
                minHeight: 300,
                maxHeight: 600,
                close: function (ev, ui) {
                    $(this).remove();
                }
            });
        }
    };
    Helper.isValidISSN = function (issn) {
        issn = issn.replace(/[^\dX]/gi, '');
        if (issn.length != 8) {
            return false;
        }
        var chars = issn.split('');
        if (chars[7].toUpperCase() == 'X') {
            chars[7] = String.fromCharCode(10);
        }
        var sum = 0;
        for (var i = 0; i < chars.length; i++) {
            sum += ((8 - i) * parseInt(chars[i]));
        }
        return ((sum % 11) == 0);
    };
    // This functions takes a string containing
    // an ISBN (ISBN-10 or ISBN-13) and returns
    // true if it's valid or false if it's invalid.
    Helper.isValidISBN = function (isbn) {
        if (isbn.match(/[^0-9xX\.\-\s]/)) {
            return false;
        }
        isbn = isbn.replace(/[^0-9xX]/g, '');
        if (isbn.length != 10 && isbn.length != 13) {
            return false;
        }
        var checkDigit = 0;
        if (isbn.length == 10) {
            checkDigit = (11 - ((10 * parseInt(isbn.charAt(0)) +
                9 * parseInt(isbn.charAt(1)) +
                8 * parseInt(isbn.charAt(2)) +
                7 * parseInt(isbn.charAt(3)) +
                6 * parseInt(isbn.charAt(4)) +
                5 * parseInt(isbn.charAt(5)) +
                4 * parseInt(isbn.charAt(6)) +
                3 * parseInt(isbn.charAt(7)) +
                2 * parseInt(isbn.charAt(8))) % 11)) % 11;
            if (checkDigit == 10) {
                return (isbn.charAt(9) == 'x' || isbn.charAt(9) == 'X') ? true : false;
            }
            else {
                return (parseInt(isbn.charAt(9)) == checkDigit ? true : false);
            }
        }
        else {
            checkDigit = 10 - ((1 * parseInt(isbn.charAt(0)) +
                3 * parseInt(isbn.charAt(1)) +
                1 * parseInt(isbn.charAt(2)) +
                3 * parseInt(isbn.charAt(3)) +
                1 * parseInt(isbn.charAt(4)) +
                3 * parseInt(isbn.charAt(5)) +
                1 * parseInt(isbn.charAt(6)) +
                3 * parseInt(isbn.charAt(7)) +
                1 * parseInt(isbn.charAt(8)) +
                3 * parseInt(isbn.charAt(9)) +
                1 * parseInt(isbn.charAt(10)) +
                3 * parseInt(isbn.charAt(11))) % 10);
            if (checkDigit == 10) {
                return (parseInt(isbn.charAt(12)) == 0 ? true : false);
            }
            else {
                return (parseInt(isbn.charAt(12)) == checkDigit ? true : false);
            }
        }
    };
    Helper.isValidUrl = function (url) {
        //  var validUrlPattern = /^(http(?:s)?\:\/\/[a-zA-Z0-9\-]+(?:\.[a-zA-Z0-9\-]+)*\.[a-zA-Z]{2,6}(?:\/?|(?:\/[\w\-]+)*)(?:\/?|\/\w+\.[a-zA-Z]{2,4}(?:\?[\w]+\=[\w\-]+)?)?(?:\&[\w]+\=[\w\-]+)*)$/;
        var validUrlPattern = /^http(?:s)?\:\/\/[-a-zA-Z0-9@:%_\+.~#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?/gi;
        return (url.match(validUrlPattern) != null);
    };
    Helper.getHostName = function (url) {
        var ll;
        ll = document.createElement("a");
        ll.href = url;
        var port = ll.port;
        if (port == "80")
            port = "";
        return ll.protocol + '//' + ll.hostname + (port ? ':' + port : '');
    };
    Helper.getPathName = function (url) {
        var ll;
        ll = document.createElement("a");
        ll.href = url;
        return ll.pathname;
    };
    Helper.getAllButHostName = function (url) {
        var ll;
        ll = document.createElement("a");
        ll.href = url;
        var port = ll.port;
        if (port == "80")
            port = "";
        var hn = ll.protocol + '//' + ll.hostname + (port ? ':' + port : '');
        var hostNameLength = hn.length;
        var rem = ll.href.substr(hostNameLength + 1, ll.href.length - hostNameLength);
        return rem;
    };
    Helper.htmlEscape = function (str) {
        return String(str)
            .replace(/&/g, '&amp;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;');
    };
    return Helper;
}());
//# sourceMappingURL=obrowser_helper.js.map
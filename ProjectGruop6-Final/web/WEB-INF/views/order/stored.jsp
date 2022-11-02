<%@taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <!--<meta http-equiv="X-UA-Compatible" content="IE=edge">-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--         Bootstrap CSS 
                <link rel="stylesheet" href="../css/bootstrap.css" />
                <link rel="stylesheet" href="../css/flaticon.css" />
                <link rel="stylesheet" href="../css/themify-icons.css" />
                <link rel="stylesheet" href="../vendors/owl-carousel/owl.carousel.min.css" />
                <link rel="stylesheet" href="../vendors/nice-select/css/nice-select.css" />-->
        <!-- main css -->
        <link href="../css/main.css" rel="stylesheet" type="text/css"/>
        <title>Document</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty productList}">
                <div class="container latest_blog_area" style="padding: 0;">
                    <h2 style="text-align: center; ">Duyệt sản phẩm ${productModal}</h2>
                    <ul class="nav nav-tabs registration_area" style="margin-bottom: 20px;">               
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="<c:url value="/order/stored.do?status=ar"/>">Đang bán</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link " href="<c:url value="/order/stored.do?status=nary"/>">Đang chờ duyệt</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link " href="<c:url value="/order/stored.do?status=nar"/>">Không được duyệt</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link " href="<c:url value="/order/stored.do?status=ss"/>">Ngừng bán</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link " href="<c:url value="/order/stored.do?status=oos"/>">Hết hàng</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link " href="#">Dashboard</a>
                        </li>
                    </ul>
                    <table class="table table-striped" id="productTable">
                        <thead style="background-color: #FFEFD5;">
                            <tr id="list-header">
                                <th class="col-2" scope="col">Ngày đăng</th>
                                <th class="col-2" scope="col">Sản phẩm</th>
                                <th scope="col" class="col-2">Hình ảnh</th>
                                <th class="col-2" scope="col">Giá</th>
                                <th class="col-1" scope="col"></th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <!-- Large modal -->
                <!--<button type="button" class="btn btn-primary" >Large modal</button>-->
                <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="container">
                                <form class="product-form">
                                    <div class="row">
                                        <div class="col-lg-5 col-md-5 col-sm-5">
                                            ${productModal}
                                        </div>
                                        <div class="col-lg-7 col-md-7 col-sm-7">
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text" id="basic-addon1">Tên sản Phẩm</span>
                                                </div>
                                                <input type="text" class="form-control product-name"
                                                       name="name"
                                                       placeholder="Tên sản Phẩm" aria-label="Tên sản Phẩm" aria-describedby="basic-addon1">
                                            </div>
                                            <h5>Danh mục sản phẩm</h5>
                                            <select class="select-category">
                                                <c:forEach items="${sessionScope.cateList}" var="i" >
                                                    <option value="${i.cateId}">${i.name}</option>
                                                </c:forEach>
                                            </select>
                                            <div class="input-group mb-3 mt-3">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">Giá sản phẩm</span>
                                                </div>
                                                <input type="text" id="formattedMoneyField"
                                                       name="price"
                                                       class="form-control" aria-label="Amount (to the nearest dollar)">
                                                <div class="input-group-append">
                                                    <span class="input-group-text">₫</span>
                                                </div>
                                            </div>
                                            <div class="input-group mb-3 mt-3">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">Số lượng sản phẩm</span>
                                                </div>
                                                <input type="text"id="formattedNumberField"
                                                       name="quantity"
                                                       class="form-control" aria-label="Amount (to the nearest dollar)"
                                                       value="4">
                                            </div>
                                            <h5>Mô tả sản phẩm</h5>
                                            <div id="description">
                                            </div>
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text" id="basic-addon1">@</span>
                                                </div>
                                                <input class="form-control seller-email"
                                                       name="sellerEmail"
                                                       type="email" placeholder="Email" readonly value="${sessionScope.user.email}">
                                            </div>
                                            <input class="description-hidden" 
                                                   name="descriptionHidden"
                                                   type="text" readonly hidden  >
                                            <input readonly 
                                                   name="cateId"
                                                   hidden class="category-hidden">
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                            <input type="file" name="img" multiple accept="image/*"/>
                                        </div>
                                        <!--                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                                                                    a
                                                                                </div>
                                                                                <div class="col-lg-2 col-md-2 col-sm-2">
                                                                                    a
                                                                                </div>
                                                                                <div class="col-lg-2 col-md-2 col-sm-2">
                                                                                    a
                                                                                </div>
                                                                                <div class="col-lg-2 col-md-2 col-sm-2">
                                                                                    a
                                                                                </div>
                                                                                <div class="col-lg-2 col-md-2 col-sm-2">
                                                                                    a
                                                                                </div>-->
                                    </div>
                                    <a class="genric-btn success circle" onclick="handleProduct(${productModal.productId}, 'u', this)">Cập nhật</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <h3 style="text-align: center; margin: 50px; ">Hiện không có review nào chờ duyệt</h3>
            </c:otherwise>
        </c:choose>
        <!--        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
                <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>-->
        <!--        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
                crossorigin="anonymous"></script>-->
        <script>
            var table;
            var productList = ${productList};
            function formatPrice(price) {
                return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(parseInt(price));
            }
            function initTableData() {
                var modifiedUsers = productList.map(p => {
//                    onclick="handleProduct(' + p.productId + ', \'u\', this)
// data-toggle="modal" data-target=".bd-example-modal-lg"
                    const dt = '<a href="/ProjectGroup6/home/productDetail.do?productId=' + p.productId + '" target="_blank" class="genric-btn info circle">Chi tiết</a>';
                    const dta = '<a class="genric-btn info circle" onclick="handleProduct(' + 1 + ')" data-toggle="modal" data-target=".bd-example-modal-lg">Chi tiết</a>';
                    const ss = '<a class="genric-btn warning circle" onclick="handleProduct(' + p.productId + ', \'ss\', this)">Ngừng bán</a>';
                    const as = '<a class="genric-btn primary circle" onclick="handleProduct(' + p.productId + ', \'as\', this)">Bán lại</a>';
                    const d = '<a class="genric-btn danger circle" onclick="handleProduct(' + p.productId + ', \'d\', this)">Xóa</a>';
                    const u = '<a class="genric-btn success circle" href="/ProjectGroup6/order/stored.do?pId=' + p.productId + '&func=u">Cập nhật</a>';
                    const b = '<div class="button-group-area mt-40" style="display: flex; flex-direction: column">';
                    const a = '</div>';
                    if (String('${status}') == 'ar') {
                        option = dt + u + ss
                    } else if (String('${status}') == 'nar') {
                        option = dt + u + d
                    } else if (String('${status}') == 'nary') {
                        option = dta + u + d
                    } else if (String('${status}') == 'ss') {
                        option = dt + as + d
                    } else if (String('${status}') == 'oos') {
                        option = dt + u + d
                    }
                    return {
                        id: p.productId,
                        date: p.date,
                        name: `<a href="/ProjectGroup6/home/productDetail.do?productId=` + p.productId + `"> 
                                  <p class="tooltip-text">` + p.name + `<span>` + p.name + `</span></p>`,
                        image: p.image,
                        price: `<div style="display: flex; justify-content: flex-end; padding-top: 5px; color: red;">` + formatPrice(p.price) +
                                `</div>`,
                        option: b + option + a,
                        description: p.description
                    }
                })
                table = $('#productTable').DataTable({
                    "processing": true,
                    "responsive": true,
                    data: modifiedUsers,
                    columns: [
                        {data: 'date'},
                        {data: 'name'},
                        {data: 'image',
                            render: function (data) {
                                if (data == "" || data == null) {
                                    return null;
                                }
                                return '<img src="' + data + '" alt="' + data + '"height="150" width="150"/>';
                            }
                        },
                        {data: 'price'},
                        {data: 'option'},
                    ]
                })
            }
            const getProduct = (pId, option) => {
                $.ajax('<c:url value="/GetProductAjax"/>', {
                    data: {
                        pId: pId,
                        func: "getProduct"
                    },
                    success: function (data) {
                        console.log("ok")
                        fetch('<c:url value="/FileProductHandle"/>', {
                            method: "POST",
                            body: formData,
                        })
                    }
                })
            }
            const handleProduct = (pId, option, el) => {
                if (option == 'ss' || option == 'as' || option == 'd') {
                    switch (option) {
                        case 'ss':
                            text = 'Xác nhận ngừng bán sản phẩm !!!';
                            break;
                        case 'as':
                            text = 'Xác nhận bán lại sản phẩm !!!';
                            break;
                        case 'd':
                            text = 'Xác nhận xóa sản phẩm !!!';
                            break;
                        default:
                            break;
                    }
                    swal({
                        title: "",
                        text: text,
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    })
                            .then((commit) => {
                                if (commit) {
                                    $.ajax("<c:url value="/order/stored.do"/>", {
                                        data: {
                                            pId: pId,
                                            func: option,
                                        },
                                        success: function (data, textStatus, jqXHR) {
                                            swal("Thành công", {
                                                icon: "success",
                                            });
                                            const tableRow = el.parentElement.parentElement.parentElement
                                            tableRow.remove()
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            swal("Thất bại!!!", {
                                                icon: "error",
                                            });
                                        }
                                    })
                                }
                            });
                } else if (option == 'u') {
                    var objJson = {
                        pId: pId,
                        name: "a",
                        price: 2,
                        description: "description",
                        cateId: 1,
                        quantity: $("input[name='quantity']").val(),
                        img1: '1',
                        img2: '2',
                        img3: '3',
                        img4: '4',
                        img5: '5'
                    };
                    swal({
                        title: "",
                        text: 'Xác nhận cập nhật sản phẩm !!!',
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    })
                            .then((commit) => {
                                if (commit) {
                                    $.ajax("<c:url value="/order/stored.do"/>", {
                                        data: {
                                            pId: pId,
                                            func: option,
                                            product: JSON.stringify(objJson),
                                        },
                                        success: function (data, textStatus, jqXHR) {
                                            swal("Thành công", {
                                                icon: "success",
                                            });
                                            const tableRow = el.parentElement.parentElement
                                            tableRow.remove()
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            swal("Thất bại!!!", {
                                                icon: "error",
                                            });
                                        }
                                    })
                                }
                            });
                }

            }
            $(document).ready(function () {
                initTableData();
            });
        </script>
    </body>
</html>

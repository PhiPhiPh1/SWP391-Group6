<%@taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">


        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>


        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
              integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />

        <style>
            .product .container{
                margin-top: 50px;
            }

            .product__item {
                width: 100%;
                transition: 0.5s;
            }

            .product__item a {
                color: black;
                font-size: 18px;
            }

            .product__item img {
                transition: 0.5s;
            }

            .product__item img:hover {
                transform: translateY(-5px);
                transition: 0.5s;
            }

            .product__item a:hover {
                color:blue;
                text-decoration: none;
            }

            .product__item img {
                height: 230px;
            }

            .product__item span {
                font-size: 20px;
                color: red;
            }
            .next {
                margin-top: 50px;
            }
        </style>
    </head>
    <body>
        <div class="sort">
            <div class="container d-flex">
                <div class="dropdown">
                    <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                        Sắp xếp theo
                    </button>
                    <div class="dropdown-menu panel-collapse">
                        <button class="dropdown-item" onclick="sortAjax(1, this)">Giá tăng dần</button>
                        <button class="dropdown-item" onclick="sortAjax(2, this)">Giá giảm dần</button>
                        <button class="dropdown-item" onclick="sortAjax(3, this)">Từ a tới z</button>
                        <button class="dropdown-item" onclick="sortAjax(4, this)">Từ z tới a</button>
                        <button class="dropdown-item" onclick="sortAjax(5, this)">Bán chạy</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="product">
            <div class="container">

                <div class="product__content row">

                    <c:forEach items="${productList}" var="i">
                        <div class="product__item col-lg-3 col-md-4 col-sm-6">
                            <a href="<c:url value="/home/productDetail.do?productId=${i.productId}"/>">
                                <img class="img-fluid" src="${i.getMainImage().url}" alt="">
                                <p>${i.name}</p>
                                <fmt:setLocale value="vi_VN"/>
                                <span><fmt:formatNumber value="${i.price}" type="currency"/></span>
                            </a>
                        </div>
                    </c:forEach>

                </div>
                <nav class="next" aria-label="Page navigation example">
                    <ul class="pagination d-flex justify-content-center">
                       <c:forEach begin="1" end="${pageNum}" var="i">
                            <li class="page-item ${i == 1 ? "active" : ""}"><button class="page-link" onclick="pagingAjax(this, event)">${i}</button></li>
                        </c:forEach> 
                    </ul>
                </nav>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.1.1.min.js">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js" integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz" crossorigin="anonymous"></script>
        <script>
            const parrentElement = document.querySelector(".product__content.row");
//            dom tới thằng container chứa các productlist
            const pageElements = document.querySelector(".pagination.d-flex.justify-content-center").querySelectorAll(".page-item");
//            DOM tới các button chuyển trang
            let getPageNumber = () => {
                let count = 0;
                for (var i = 0; i < pageElements.length; i++) {
                    if (pageElements[i].classList.contains("active"))
                        break;
                    else
                        count++;
                }
                return count + 1;
            }
//            ví dụ khi người dùng click vào trang 2
//            thì cái nút thứ 2 nó sẽ có class active
//            mình sẽ dùng for loop để đếm và dừng lại khi thấy element có class active 
//            và trả về count + 1. Tại sao lại là count + 1, vì khi debug mới phát hiện ra 

//            pagination
            const getCateId = () => {
                const queryString = window.location.search;
                const urlParams = new URLSearchParams(queryString);
                // url params = các query string của url 
//                vd: home.do?a=1&b=2&c=3
//                  thì sau dấu ? nó là query string với các parameter là a, b, c
                return urlParams.get("cateId");
                // return giá trị của thằng parameter tên là cateId
            }
            const formatVND = (currency) => {
            // chuyển int sang vnd 
                return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(currency);
            }
            const removeActiveClass = () => {
            // khi người dùng bấm vào các nút trang ( vd trang thứ 1, trang thứ 2)
            // thì đầu tiên là phải xóa active class đi 
                document.querySelectorAll(".page-item.active").forEach(i => {
                    i.classList.remove("active")
                })
            }
            const renderData = (productData) => {
            // render data thì bỏ data vô html
                parrentElement.innerHTML = ""
                // xóa container 
                let mainImgUrl = ""
                // khai báo cái main img 
                // productData nó là 1 mảng object json
                // với 1 phần tử = 1 product
                // => 1 product nó sẽ có 1 mảng image
                productData.forEach(i => {
                    i.imgList.forEach(img => {
                        if (img.isMainImg)
                            mainImgUrl = img.url;
                    });
                    // tìm thằng main image trong cái image list của product
                    parrentElement.innerHTML +=
                            '<div class="product__item col-lg-3 col-md-4 col-sm-6">' +
'<a href="productDetail.do?id=' + i.productId + '">' +
                            '<img class="img-fluid" src="' + mainImgUrl + '" alt="">' +
                            '</a>' +
                            '<a href="productDetail.do?id=' + i.productId + '">' + i.name + '</a><br>' +
                            '<span>' + formatVND(i.price) + '</span>' +
                            '</div>'
                    // đổ data ra html
                })
            }
            const sortAjax = (id, el) => {
                document.querySelector(".btn.btn-primary.dropdown-toggle").innerHTML = el.innerHTML;
                // thay đổi nội dung bên trong button sort 
                $.ajax("/ProjectGroup6/GetProductAjax", {
                    data: {
                        func: 'getSortedProductList',
                        option: id,
                        cateId: getCateId(),
                        pageNum: getPageNumber(),
                    },
                    success: function (data) {
//                        console.log(data)
                        renderData(data)
                    }
                })
            }
            const pagingAjax = (el, event) => {
//                event.preventDefault();
                removeActiveClass()
                // xóa active class tất cả các nút paging
                el.parentElement.classList.add("active")
                // thêm class active vào nút pagin mà mình đã bấm
                console.log(getPageNumber())
                
                 $.ajax("/ProjectGroup6/GetProductAjax", {
                    data: {
                        cateId: getCateId(),
                        func: 'getSortedProductList',
                        pageNum: getPageNumber() ,
                    },
                    success: function (data) {
                        renderData(data)
                    }
                })
            }
        </script>

    </body>
</html>

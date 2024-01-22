<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <style>
        /* Reset some default styles */
        body, h1, h2, h3, p, ul, li {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        body {
            font-family: 'Arial', sans-serif;
        }

        /* Footer Styles */
        footer {
            background-color: #333;
            color: #fff;
            padding: 30px 0;
        }

        .footer-area {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .single-footer-caption {
            margin-bottom: 50px;
        }

        .footer-tittle h4 {
            font-size: 20px;
            margin-bottom: 20px;
            color: #fff;
        }

        .footer-tittle ul {
            padding: 0;
            margin: 0;
        }

        .footer-tittle li {
            margin-bottom: 10px;
        }

        /* Responsive Styles */
        @media (max-width: 767px) {
            .footer-area {
                flex-direction: column;
            }

            .single-footer-caption {
                width: 100%;
                text-align: center;
            }
        }
    </style>

    <footer>
        <div class="footer-area">
            <div class="single-footer-caption">
                <!-- Your logo goes here -->
            </div>

            <div class="single-footer-caption">
                <div class="footer-tittle">
                    <h4>Liên kết nhanh</h4>
                    <ul>
                        <li><a href="#">Giới thiệu</a></li>
                        <li><a href="#">Ưu đãi & Giảm giá</a></li>
                        <li><a href="#">Nhận phiếu giảm giá</a></li>
                        <li><a href="#">Liên hệ với chúng tôi</a></li>
                    </ul>
                </div>
            </div>

            <div class="single-footer-caption">
                <div class="footer-tittle">
                    <h4>Sản phẩm mới</h4>
                    <ul>
                        <li><a href="#">Âm nhạc Amazon</a></li>
                        <li><a href="#">Amazon Drive</a></li>
                        <li><a href="#">AbeBooks</a></li>
                        <li><a href="#">Shopbop</a></li>
                    </ul>
                </div>
            </div>

            <div class="single-footer-caption">
                <div class="footer-tittle">
                    <h4>Hỗ trợ</h4>
                    <ul>
                        <li><a href="#">Câu hỏi thường gặp</a></li>
                        <li><a href="#">Điều khoản & Điều kiện</a></li>
                        <li><a href="#">Chính sách quyền riêng tư</a></li>
                        <li><a href="#">Báo cáo vấn đề thanh toán</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>


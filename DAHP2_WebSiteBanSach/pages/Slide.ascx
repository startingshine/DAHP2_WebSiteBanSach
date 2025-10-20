<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Slide.ascx.cs" Inherits="DAHP2_WebSiteBanSach.pages.Slide" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background-color: #f4f4f4;
    display: flex;
    justify-content: center;
    align-items: flex-start;
}

/* Tổng khung */
.banner-container {
    display: flex;
    gap: 10px;
    width: 90%;
    max-width: 1400px;
}

/* BÊN TRÁI - SLIDER */
.left-slider {
    position: relative;
    width: 65%;
    overflow: hidden;
    border-radius: 10px;
}

.slide {
    opacity: 0;
    position: absolute;
    top: 0; left: 0;
    width: 100%;
    transition: opacity 0.6s ease;
}
.slide.active {
    opacity: 1;
    position: relative;
}

.slide img {
    width: 100%;
    border-radius: 10px;
}

/* Nút chuyển */
.prev, .next {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: rgba(255,255,255,0.8);
    border: none;
    cursor: pointer;
    padding: 10px;
    border-radius: 50%;
    font-size: 18px;
}

.prev:hover, .next:hover {
    background-color: rgba(255,255,255,1);
}

.prev {
    left: 10px;
}
.next {
    right: 10px;
}

/* Dấu chấm */
.dots {
    position: absolute;
    bottom: 12px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 8px;
}

.dot {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background-color: #ddd;
    cursor: pointer;
}

.dot.active {
    background-color: #d32f2f;
}

/* BÊN PHẢI - 2 ẢNH TĨNH */
.right-banner {
    width: 35%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    gap: 15px;
}

.right-banner img {
    width: 100%;
    border-radius: 10px;
    cursor: pointer;
    transition: transform 0.3s ease;
}

.right-banner img:hover {
    transform: scale(1.02);
}

</style>
<div class="banner-container">

    <!-- LEFT: SLIDER -->
    <div class="left-slider">
        <div class="slider"> 
            <div class="slider-inner">
                <div class="slide active"><img src="../anh/banner_cntt.jpg" alt="Slide 1"></div>
                <div class="slide"><img src="../anh/banner_kinhte.jpg" alt="Slide 2"></div>
                <div class="slide"><img src="../anh/banner_thieunhi.jpg" alt="Slide 3"></div>
                <div class="slide"><img src="../anh/doanhnha.jpg" alt="Slide 4"></div>
                <div class="slide"><img src="../anh/giamgia.jpg" alt="Slide 5"></div>
            </div>

            <!-- Dots -->
            <div class="dots">
                <span class="dot active"></span>
                <span class="dot"></span>
                <span class="dot"></span>
                <span class="dot"></span>
                <span class="dot"></span>
            </div>
        </div>

        <!-- IMPORTANT: type="button" để không submit form -->
        <button type="button" class="prev"><i class="fa fa-chevron-left"></i></button>
        <button type="button" class="next"><i class="fa fa-chevron-right"></i></button>
    </div>

    <!-- RIGHT: 2 STATIC IMAGES -->
    <div class="right-banner">
        <img src="../anh/Sacombank10_392x156.jpg" alt="Banner 1">
        <img src="../anh/TanViet10_bac_resize840x320.png" alt="Banner 2">
    </div>

</div>
<script>
    window.addEventListener("DOMContentLoaded", () => {
        const leftSlider = document.querySelector('.left-slider');
        const sliderInner = leftSlider.querySelector('.slider-inner'); // vùng chứa slide để nhận pointer events
        const slides = Array.from(leftSlider.querySelectorAll('.slide'));
        const dots = Array.from(leftSlider.querySelectorAll('.dot'));
        const nextBtn = leftSlider.querySelector('.next');
        const prevBtn = leftSlider.querySelector('.prev');

        let index = 0;
        let slideInterval = null;

        function showSlide(n) {
            index = (n + slides.length) % slides.length;
            slides.forEach((s, i) => s.classList.toggle('active', i === index));
            dots.forEach((d, i) => d.classList.toggle('active', i === index));
        }

        function nextSlide() {
            showSlide(index + 1);
        }

        function prevSlide() {
            showSlide(index - 1);
        }

        function resetInterval() {
            if (slideInterval) clearInterval(slideInterval);
            slideInterval = setInterval(nextSlide, 3000);
        }

        // Nút chuyển (loại bỏ hành vi submit bằng type="button")
        nextBtn.addEventListener('click', (e) => { e.preventDefault(); nextSlide(); resetInterval(); });
        prevBtn.addEventListener('click', (e) => { e.preventDefault(); prevSlide(); resetInterval(); });

        // Dots
        dots.forEach((dot, i) => {
            dot.addEventListener('click', (e) => {
                e.preventDefault();
                showSlide(i);
                resetInterval();
            });
        });

        // ========== Swipe / Drag using Pointer Events ==========
        // pointer events unify mouse & touch & pen
        let pointerDown = false;
        let startX = 0;
        let currentX = 0;

        sliderInner.style.touchAction = "pan-y"; // cho phép vuốt ngang được nhận; ngăn trình duyệt xử lý gesture ngang

        sliderInner.addEventListener('pointerdown', (e) => {
            pointerDown = true;
            startX = e.clientX;
            currentX = startX;
            // khi người bắt đầu thao tác, tạm dừng auto để tránh xung đột
            if (slideInterval) clearInterval(slideInterval);
            sliderInner.setPointerCapture(e.pointerId);
        });

        sliderInner.addEventListener('pointermove', (e) => {
            if (!pointerDown) return;
            currentX = e.clientX;
            // nếu bạn muốn, có thể thêm visual feedback ở đây (translate ảnh theo currentX-startX)
        });

        sliderInner.addEventListener('pointerup', (e) => {
            if (!pointerDown) return;
            pointerDown = false;
            const diff = currentX - startX;
            // threshold 50px để tránh touch nhỏ vô tình
            if (Math.abs(diff) > 50) {
                if (diff > 0) prevSlide();
                else nextSlide();
            }
            resetInterval();
            try { sliderInner.releasePointerCapture(e.pointerId); } catch (err) { }
        });

        sliderInner.addEventListener('pointercancel', (e) => {
            pointerDown = false;
            resetInterval();
            try { sliderInner.releasePointerCapture(e.pointerId); } catch (err) { }
        });

        // Khởi động auto
        resetInterval();

        // Optional: stop auto khi con trỏ vào slider (tốt cho UX)
        leftSlider.addEventListener('mouseenter', () => { if (slideInterval) clearInterval(slideInterval); });
        leftSlider.addEventListener('mouseleave', () => { resetInterval(); });

        // Prevent images from being dragged (UX)
        slides.forEach(s => {
            const img = s.querySelector('img');
            if (img) {
                img.addEventListener('dragstart', (e) => e.preventDefault());
            }
        });
    });
</script>
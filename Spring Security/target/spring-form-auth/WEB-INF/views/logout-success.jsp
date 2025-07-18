<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout Successful</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }

        #threejs-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        h1 {
            color: #fff;
            text-shadow: 0 0 10px rgba(0,0,0,0.5);
            margin-bottom: 30px;
        }

        .content {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            text-align: center;
            backdrop-filter: blur(5px);
        }

        a {
            padding: 12px 25px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s ease;
            display: inline-block;
        }

        a:hover {
            background-color: #0056b3;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
</head>
<body>
    <div id="threejs-background"></div>

    <div class="content">
        <h1>You have been logged out successfully!</h1>
        <a href="<c:url value='/login' />">Login Again</a>
    </div>

    <script>
        // Three.js initialization
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        document.getElementById('threejs-background').appendChild(renderer.domElement);

        // Create floating bubbles
        const bubbles = [];
        const bubbleGeometry = new THREE.SphereGeometry(0.1, 32, 32);

        for(let i = 0; i < 50; i++) {
            const material = new THREE.MeshBasicMaterial({
                color: new THREE.Color(Math.random(), Math.random(), Math.random()),
                transparent: true,
                opacity: 0.7
            });

            const bubble = new THREE.Mesh(bubbleGeometry, material);

            bubble.position.x = (Math.random() - 0.5) * 10;
            bubble.position.y = (Math.random() - 0.5) * 10;
            bubble.position.z = (Math.random() - 0.5) * 10;

            bubble.userData = {
                speedX: Math.random() * 0.01 - 0.005,
                speedY: Math.random() * 0.01 - 0.005,
                speedZ: Math.random() * 0.01 - 0.005
            };

            scene.add(bubble);
            bubbles.push(bubble);
        }

        // Add ambient light
        const ambientLight = new THREE.AmbientLight(0x404040);
        scene.add(ambientLight);

        camera.position.z = 5;

        // Animation loop
        function animate() {
            requestAnimationFrame(animate);

            // Animate bubbles
            bubbles.forEach(bubble => {
                bubble.position.x += bubble.userData.speedX;
                bubble.position.y += bubble.userData.speedY;
                bubble.position.z += bubble.userData.speedZ;

                // Boundary check
                if(Math.abs(bubble.position.x) > 5) bubble.userData.speedX *= -1;
                if(Math.abs(bubble.position.y) > 5) bubble.userData.speedY *= -1;
                if(Math.abs(bubble.position.z) > 5) bubble.userData.speedZ *= -1;
            });

            renderer.render(scene, camera);
        }

        animate();

        // Handle window resize
        window.addEventListener('resize', () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        });
    </script>
</body>
</html>
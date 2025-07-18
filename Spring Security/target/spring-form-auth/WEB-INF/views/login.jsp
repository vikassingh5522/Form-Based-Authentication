<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
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
        }

        form {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            width: 300px;
            text-align: center;
            backdrop-filter: blur(5px);
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: rgba(255,255,255,0.8);
        }

        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        .error {
            color: red;
            margin-bottom: 15px;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
</head>
<body>
    <div id="threejs-background"></div>

    <h1>Login</h1>

    <form action="<c:url value='/login' />" method="post">
        <!-- Display login error if any -->
        <c:if test="${param.error != null}">
            <div class="error">Invalid username or password.</div>
        </c:if>

        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required />

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required />

        <!-- CSRF token for protection -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <button type="submit">Login</button>
    </form>

    <script>
        // Three.js initialization
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        document.getElementById('threejs-background').appendChild(renderer.domElement);

        // Create colorful particles
        const particlesGeometry = new THREE.BufferGeometry();
        const particleCount = 1500;

        const posArray = new Float32Array(particleCount * 3);
        const colorArray = new Float32Array(particleCount * 3);

        for(let i = 0; i < particleCount * 3; i++) {
            posArray[i] = (Math.random() - 0.5) * 10;
            colorArray[i] = Math.random();
        }

        particlesGeometry.setAttribute('position', new THREE.BufferAttribute(posArray, 3));
        particlesGeometry.setAttribute('color', new THREE.BufferAttribute(colorArray, 3));

        const particlesMaterial = new THREE.PointsMaterial({
            size: 0.05,
            vertexColors: true,
            transparent: true,
            opacity: 0.8,
            blending: THREE.AdditiveBlending
        });

        const particlesMesh = new THREE.Points(particlesGeometry, particlesMaterial);
        scene.add(particlesMesh);

        // Add a central glowing sphere
        const sphereGeometry = new THREE.SphereGeometry(1, 32, 32);
        const sphereMaterial = new THREE.MeshBasicMaterial({
            color: 0x00a8ff,
            transparent: true,
            opacity: 0.2
        });
        const sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
        scene.add(sphere);

        camera.position.z = 5;

        // Animation loop
        function animate() {
            requestAnimationFrame(animate);

            // Rotate particles
            particlesMesh.rotation.x += 0.0005;
            particlesMesh.rotation.y += 0.0005;

            // Pulsing sphere
            sphere.scale.x = 1 + Math.sin(Date.now() * 0.001) * 0.2;
            sphere.scale.y = 1 + Math.sin(Date.now() * 0.001) * 0.2;
            sphere.scale.z = 1 + Math.sin(Date.now() * 0.001) * 0.2;

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
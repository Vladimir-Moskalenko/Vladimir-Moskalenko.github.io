function isDesktop() {
    return !/Mobi|Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
}

(() => {
    const canvas = document.getElementById("bgDots");
    const ctx = canvas.getContext("2d", { alpha: true });

    let w = window.innerWidth,
        h = window.innerHeight,
        dpr = Math.max(1, window.devicePixelRatio || 1),
        mX = -100,
        mY = -100,
        ws = [];
    const spacing = 24,
        baseR = 1,
        maxR = 2,
        wSpeed = 350,
        wWidth = 40,
        wLife = 2300;

    function getDims() {
        dpr = Math.max(1, window.devicePixelRatio || 1);
        w = window.innerWidth;
        h = window.innerHeight;

        canvas.width = Math.floor(w * dpr);
        canvas.height = Math.floor(h * dpr);
        canvas.style.width = w + "px";
        canvas.style.height = h + "px";

        ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    }

    window.addEventListener("getDims", getDims, { passive: true });

    if (isDesktop()) {
        window.addEventListener(
            "mousemove",
            (event) => {
                mX = event.clientX;
                mY = event.clientY;
            },
            { passive: true }
        );
    }

    window.addEventListener("click", (event) => {
        ws.push({
            x: event.clientX,
            y: event.clientY,
            start: performance.now()
        });
    });

    function draw() {
        ctx.clearRect(0, 0, w, h);
        const now = performance.now();

        ws = ws.filter((wave) => now - wave.start <= wLife);

        for (let y = 0; y <= h; y += spacing) {
            for (let x = 0; x <= w; x += spacing) {
                const dx = x - mX,
                    dy = y - mY;

                let intensity = Math.max(0, 1 - Math.sqrt(dx ** 2 + dy ** 2) / 100);

                for (let i = ws.length - 1; i >= 0; i--) {
                    const w = ws[i],
                        age = now - w.start;

                    intensity = Math.max(
                        intensity,
                        Math.exp(
                            -((Math.sqrt((x - w.x) ** 2 + (y - w.y) ** 2) - (age / 1000) * wSpeed) ** 2) /
                                (2 * (wWidth * 0.5 * (0.3 + 0.7 * (1 - age / wLife) ** 2)) ** 2)
                        ) *
                            (1 - age / wLife) ** 2
                    );
                }

                const r = baseR + intensity * (maxR - baseR);
                ctx.beginPath();
                ctx.arc(x, y, r, 0, Math.PI * 2);

                ctx.fillStyle = window
                    .getComputedStyle(document.documentElement)
                    .getPropertyValue("--dot-color")
                    .trim();
                ctx.fill();
            }
        }

        requestAnimationFrame(draw);
    }

    getDims();
    draw();
})();

function openVS() {
    voteSites = [
        "https://topminecraftservers.org/vote/44054",
        "https://minecraft.buzz/vote/basicallymc",
        "https://minecraftservers.org/vote/690491",
        "https://minecraft-mp.com/server/361164/vote/",
        "https://minecraftbestservers.com/server-basicallymc.7102/vote"
    ];

    for (let i = 0; i < 5; i++) {
        window.open(voteSites[i]);
    }
}

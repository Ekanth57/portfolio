# Portfolio Analytics Setup Guide

## 🚀 How to Track Visitors to Your Portfolio

### Method 1: Google Analytics 4 (Recommended)

#### Step 1: Create Google Analytics Account
1. Go to [analytics.google.com](https://analytics.google.com)
2. Click "Start measuring" 
3. Create an account and property
4. Choose "Web" platform
5. Enter your website URL: `https://ekanth57.github.io/portfolio/`

#### Step 2: Get Your Measurement ID
1. After creating the property, you'll get a **Measurement ID** (format: G-XXXXXXXXXX)
2. Copy this ID

#### Step 3: Update Your Portfolio
1. Open `/web/index.html` in your portfolio
2. Replace both instances of `GA_MEASUREMENT_ID` with your actual Measurement ID
3. Example: Change `GA_MEASUREMENT_ID` to `G-ABC123DEF4`

#### Step 4: Deploy Updated Portfolio
```bash
git add .
git commit -m "Add Google Analytics tracking"
git push
```

### Method 2: GitHub Repository Insights (Basic)

1. Go to your repository: https://github.com/Ekanth57/portfolio
2. Click "Insights" tab
3. Click "Traffic" in the left sidebar
4. View basic visitor statistics (last 14 days)

### Method 3: Simple Analytics (Privacy-Focused Alternative)

1. Sign up at [simpleanalytics.com](https://simpleanalytics.com)
2. Add this script to your `web/index.html`:
```html
<script async defer src="https://scripts.simpleanalyticscdn.com/latest.js"></script>
<noscript><img src="https://queue.simpleanalyticscdn.com/noscript.gif" alt="" referrerpolicy="no-referrer-when-downgrade" /></noscript>
```

## 📊 What You Can Track

### With Google Analytics:
- **Total visitors** and page views
- **Geographic location** of visitors
- **Device types** (mobile, desktop, tablet)
- **Traffic sources** (direct, search, social media)
- **User behavior** and session duration
- **Real-time visitor count**

### With GitHub Insights:
- **Basic visitor count** (last 14 days)
- **Referring sites**
- **Popular content**

## 🎯 Analytics Features Already Added

Your portfolio now includes:
- ✅ Google Analytics 4 integration (needs your Measurement ID)
- ✅ Analytics helper class for custom event tracking
- ✅ Improved page title for better SEO
- ✅ Meta description for search engines

## 📈 Advanced Tracking (Optional)

You can track specific events like:
- Project card clicks
- Social media button clicks
- Contact form interactions
- Download button clicks

The `Analytics` class in your Flutter code is ready for this!

## 🔍 Viewing Your Analytics

After setup:
1. **Google Analytics:** Visit analytics.google.com
2. **GitHub Insights:** Visit your repository → Insights → Traffic
3. **Real-time data:** Available in Google Analytics dashboard

## 📱 Mobile Analytics

Your portfolio is mobile-responsive, so you'll see:
- Desktop vs mobile visitor breakdown
- Popular screen sizes
- Mobile user behavior patterns

---

**Next Steps:**
1. Set up Google Analytics account
2. Get your Measurement ID
3. Replace GA_MEASUREMENT_ID in web/index.html
4. Push changes to GitHub
5. Start tracking visitors! 🎉
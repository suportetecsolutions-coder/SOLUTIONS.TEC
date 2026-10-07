.class public Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;
.super Landroid/support/v7/app/AppCompatActivity;

# interfaces
.implements Lcom/ftgtv/ftgiptvbox/view/b/i;


# instance fields
.field a:Landroid/content/Context;

.field b:Lcom/ftgtv/ftgiptvbox/b/b/d;

.field c:Lcom/ftgtv/ftgiptvbox/b/b/a;

.field d:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/ftgtv/ftgiptvbox/b/b;",
            ">;"
        }
    .end annotation
.end field

.field private e:Landroid/content/SharedPreferences;

.field private f:Lcom/ftgtv/ftgiptvbox/c/d;

.field private g:Lcom/ftgtv/ftgiptvbox/b/b/k;

.field private h:I

.field ivGearLoader:Lcom/ftgtv/ftgiptvbox/view/utility/LoadingGearSpinner;
    .annotation build Lbutterknife/BindView;
    .end annotation
.end field

.field progressBar:Landroid/widget/ProgressBar;
    .annotation build Lbutterknife/BindView;
    .end annotation
.end field

.field rlImportLayout:Landroid/widget/RelativeLayout;
    .annotation build Lbutterknife/BindView;
    .end annotation
.end field

.field rlImportProcess:Landroid/widget/LinearLayout;
    .annotation build Lbutterknife/BindView;
    .end annotation
.end field

.field tvCountings:Landroid/widget/TextView;
    .annotation build Lbutterknife/BindView;
    .end annotation
.end field

.field tvImportingStreams:Landroid/widget/TextView;
    .annotation build Lbutterknife/BindView;
    .end annotation
.end field

.field tvPercentage:Landroid/widget/TextView;
    .annotation build Lbutterknife/BindView;
    .end annotation
.end field

.field tvSettingStreams:Landroid/widget/TextView;
    .annotation build Lbutterknife/BindView;
    .end annotation
.end field

.field private tvaquiWd:Landroid/os/Handler;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/support/v7/app/AppCompatActivity;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    return-void
.end method

.method static synthetic a(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/SharedPreferences;)Landroid/content/SharedPreferences;
    .locals 0

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    return-object p1
.end method

.method static synthetic a(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)Lcom/ftgtv/ftgiptvbox/b/b/k;
    .locals 0

    iget-object p0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    return-object p0
.end method

.method private a(Landroid/content/Context;Lcom/ftgtv/ftgiptvbox/b/b/d;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    if-eqz p3, :cond_0

    if-eqz p4, :cond_0

    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_0

    invoke-virtual {p4}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_0

    const-string p1, ""

    invoke-virtual {p3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    const-string p1, ""

    invoke-virtual {p4, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    const-string p1, "Channels"

    const-string v0, "1"

    const-string v1, "Processing"

    invoke-virtual {p2, p1, v0, v1}, Lcom/ftgtv/ftgiptvbox/b/b/d;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->f:Lcom/ftgtv/ftgiptvbox/c/d;

    invoke-virtual {p1, p3, p4}, Lcom/ftgtv/ftgiptvbox/c/d;->a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private a(Lcom/ftgtv/ftgiptvbox/b/b/d;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lcom/ftgtv/ftgiptvbox/b/b/b;

    invoke-direct {v0}, Lcom/ftgtv/ftgiptvbox/b/b/b;-><init>()V

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/ftgtv/ftgiptvbox/b/b/b;->c(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Lcom/ftgtv/ftgiptvbox/b/b/b;->d(Ljava/lang/String;)V

    const-string p2, "Channels"

    invoke-virtual {v0, p2}, Lcom/ftgtv/ftgiptvbox/b/b/b;->a(Ljava/lang/String;)V

    const-string p2, "1"

    invoke-virtual {v0, p2}, Lcom/ftgtv/ftgiptvbox/b/b/b;->b(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Lcom/ftgtv/ftgiptvbox/b/b/d;->a(Lcom/ftgtv/ftgiptvbox/b/b/b;)V

    return-void
.end method

.method private a(Lcom/ftgtv/ftgiptvbox/b/b/k;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lcom/ftgtv/ftgiptvbox/b/b/b;

    invoke-direct {v0}, Lcom/ftgtv/ftgiptvbox/b/b/b;-><init>()V

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/ftgtv/ftgiptvbox/b/b/b;->c(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Lcom/ftgtv/ftgiptvbox/b/b/b;->d(Ljava/lang/String;)V

    const-string p2, "seriesstreamscat"

    invoke-virtual {v0, p2}, Lcom/ftgtv/ftgiptvbox/b/b/b;->a(Ljava/lang/String;)V

    const-string p2, "7"

    invoke-virtual {v0, p2}, Lcom/ftgtv/ftgiptvbox/b/b/b;->b(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Lcom/ftgtv/ftgiptvbox/b/b/k;->a(Lcom/ftgtv/ftgiptvbox/b/b/b;)V

    return-void
.end method

.method static synthetic b(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)Ljava/lang/String;
    .locals 0

    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private b(Lcom/ftgtv/ftgiptvbox/b/b/k;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lcom/ftgtv/ftgiptvbox/b/b/b;

    invoke-direct {v0}, Lcom/ftgtv/ftgiptvbox/b/b/b;-><init>()V

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/ftgtv/ftgiptvbox/b/b/b;->c(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Lcom/ftgtv/ftgiptvbox/b/b/b;->d(Ljava/lang/String;)V

    const-string p2, "seriesstreams"

    invoke-virtual {v0, p2}, Lcom/ftgtv/ftgiptvbox/b/b/b;->a(Ljava/lang/String;)V

    const-string p2, "8"

    invoke-virtual {v0, p2}, Lcom/ftgtv/ftgiptvbox/b/b/b;->b(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Lcom/ftgtv/ftgiptvbox/b/b/k;->a(Lcom/ftgtv/ftgiptvbox/b/b/b;)V

    return-void
.end method

.method static synthetic c(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)Landroid/content/SharedPreferences;
    .locals 0

    iget-object p0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    return-object p0
.end method

.method private c()V
    .locals 4

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz v0, :cond_0

    const-string v0, "loginPrefs"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v1, "username"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v2, "password"

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->d()V

    iget-object v2, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    iget-object v3, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    invoke-direct {p0, v2, v3, v0, v1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a(Landroid/content/Context;Lcom/ftgtv/ftgiptvbox/b/b/d;Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method static synthetic d(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)Lcom/ftgtv/ftgiptvbox/c/d;
    .locals 0

    iget-object p0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->f:Lcom/ftgtv/ftgiptvbox/c/d;

    return-object p0
.end method

.method private d()V
    .locals 4

    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    invoke-virtual {v1}, Lcom/ftgtv/ftgiptvbox/b/b/d;->j()I

    move-result v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_1

    if-nez v1, :cond_1

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    invoke-direct {p0, v1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a(Lcom/ftgtv/ftgiptvbox/b/b/d;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    iget-object v2, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v3, 0x7f1101d1

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/ftgtv/ftgiptvbox/miscelleneious/b/d;->a(Landroid/content/Context;Ljava/lang/String;)V

    :cond_1
    :goto_0
    invoke-direct {p0, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g(Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic e(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)I
    .locals 0

    iget p0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    return p0
.end method

.method private e()Ljava/lang/String;
    .locals 1

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Date;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/ftgtv/ftgiptvbox/miscelleneious/b/d;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private f()V
    .locals 3

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x13

    if-lt v1, v2, :cond_0

    const/high16 v1, 0x4000000

    invoke-virtual {v0, v1}, Landroid/view/Window;->clearFlags(I)V

    :cond_0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x15

    if-lt v1, v2, :cond_1

    const/high16 v1, -0x80000000

    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    :cond_1
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v1, v2, :cond_2

    const v1, 0x7f0600de

    invoke-static {p0, v1}, Landroid/support/v4/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/Window;->setStatusBarColor(I)V

    :cond_2
    return-void
.end method

.method private g(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    invoke-virtual {v0}, Lcom/ftgtv/ftgiptvbox/b/b/k;->c()I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_1

    if-nez v0, :cond_1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    invoke-direct {p0, v0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a(Lcom/ftgtv/ftgiptvbox/b/b/k;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f1101d1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/ftgtv/ftgiptvbox/miscelleneious/b/d;->a(Landroid/content/Context;Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method private h(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    invoke-virtual {v0}, Lcom/ftgtv/ftgiptvbox/b/b/k;->d()I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_1

    if-nez v0, :cond_1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    invoke-direct {p0, v0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b(Lcom/ftgtv/ftgiptvbox/b/b/k;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f1101d1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/ftgtv/ftgiptvbox/miscelleneious/b/d;->a(Landroid/content/Context;Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method private tvaquiMarkSync()V
    .locals 4

    :try_start_0
    const-string v0, "tvaqui_sync"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "last_full_sync"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "loginPrefs"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v2, "username"

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "last_full_sync_user"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 5

    iget p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I


    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    const-string v1, "seriesstreamscat"

    const-string v2, "7"

    const-string v3, "Failed"

    invoke-virtual {v0, v1, v2, v3, p1}, Lcom/ftgtv/ftgiptvbox/b/b/k;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    :cond_0
    const-string p1, "loginPrefs"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v0, "username"

    const-string v1, ""

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v1, "password"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$2;

    invoke-direct {v2, p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$2;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Ljava/lang/String;Ljava/lang/String;)V

    const-wide/16 v3, 0x3e8

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_1
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/ftgtv/ftgiptvbox/b/a/d;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    if-eqz p1, :cond_2

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    invoke-virtual {v1}, Lcom/ftgtv/ftgiptvbox/b/b/k;->g()V

    :cond_0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x11

    if-lt v1, v2, :cond_1

    new-instance v1, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$d;

    iget-object v2, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v1, p0, v2, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$d;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;Ljava/util/List;)V

    sget-object p1, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array v0, v0, [Ljava/lang/String;

    invoke-virtual {v1, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$d;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-instance v1, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$d;

    iget-object v2, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v1, p0, v2, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$d;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;Ljava/util/List;)V

    new-array p1, v0, [Ljava/lang/String;

    invoke-virtual {v1, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$d;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_2
    iget p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I


    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_4

    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_3

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    const-string v2, "seriesstreamscat"

    const-string v3, "7"

    const-string v4, "Failed"

    invoke-virtual {v1, v2, v3, v4, p1}, Lcom/ftgtv/ftgiptvbox/b/b/k;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    :cond_3
    const-string p1, "loginPrefs"

    invoke-virtual {p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v0, "username"

    const-string v1, ""

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v1, "password"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$1;

    invoke-direct {v2, p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$1;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Ljava/lang/String;Ljava/lang/String;)V

    const-wide/16 v3, 0x3e8

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_4
    return-void
.end method

.method public b()V
    .locals 8

    new-instance v0, Lcom/ftgtv/ftgiptvbox/b/b/d;

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/ftgtv/ftgiptvbox/b/b/d;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    new-instance v0, Lcom/ftgtv/ftgiptvbox/b/b/a;

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/ftgtv/ftgiptvbox/b/b/a;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->c:Lcom/ftgtv/ftgiptvbox/b/b/a;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->c:Lcom/ftgtv/ftgiptvbox/b/b/a;

    const-string v1, "live"

    iget-object v2, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-static {v2}, Lcom/ftgtv/ftgiptvbox/b/b/l;->a(Landroid/content/Context;)I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/ftgtv/ftgiptvbox/b/b/a;->a(Ljava/lang/String;I)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->d:Ljava/util/ArrayList;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->d:Ljava/util/ArrayList;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->d:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_1

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->d:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_1

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->d:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/ftgtv/ftgiptvbox/b/b;

    invoke-virtual {v1}, Lcom/ftgtv/ftgiptvbox/b/b;->a()I

    move-result v3

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    invoke-virtual {v1, v3}, Lcom/ftgtv/ftgiptvbox/b/b/d;->h(I)Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v2, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->c:Lcom/ftgtv/ftgiptvbox/b/b/a;

    const-string v4, ""

    const-string v5, "live"

    const-string v6, ""

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-static {v1}, Lcom/ftgtv/ftgiptvbox/b/b/l;->a(Landroid/content/Context;)I

    move-result v7

    invoke-virtual/range {v2 .. v7}, Lcom/ftgtv/ftgiptvbox/b/b/a;->a(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 5

    iget p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I


    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_6

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    iget v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f11028b

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/ftgtv/ftgiptvbox/miscelleneious/b/d;->a(Landroid/content/Context;Ljava/lang/String;)V

    :cond_0
    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    const-string v2, "seriesstreams"

    const-string v3, "8"

    const-string v4, "Failed"

    invoke-virtual {v1, v2, v3, v4, v0}, Lcom/ftgtv/ftgiptvbox/b/b/k;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b()V

    const-string v0, "redirect_live_tv"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/LiveActivityNewFlow;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    :goto_0
    invoke-virtual {p0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->startActivity(Landroid/content/Intent;)V

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->finish()V

    return-void

    :cond_1
    const-string v0, "redirect_vod"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/VodActivityNewFlow;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_0

    :cond_2
    const-string v0, "redirect_series"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/SeriesActivtyNewFlow;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_0

    :cond_3
    const-string v0, "redirect_catchup"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/TVArchiveActivityNewFlow;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_0

    :cond_4
    const-string v0, "redirect_live_tv_epg_expired"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_5

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/ImportEPGActivity;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v0, "redirect_live_tv_epg_expired"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_0

    :cond_5
    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/NewDashboardActivity;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_0

    :cond_6
    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/ftgtv/ftgiptvbox/b/a/c;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_2

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    invoke-virtual {v0}, Lcom/ftgtv/ftgiptvbox/b/b/k;->e()V

    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x11

    const/4 v2, 0x0

    if-lt v0, v1, :cond_1

    new-instance v0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v0, p0, v1, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;Ljava/util/List;)V

    sget-object p1, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array v1, v2, [Ljava/lang/String;

    invoke-virtual {v0, p1, v1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-instance v0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v0, p0, v1, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;Ljava/util/List;)V

    new-array p1, v2, [Ljava/lang/String;

    invoke-virtual {v0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$c;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_2
    iget p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I


    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_9

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    iget v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    if-lez v0, :cond_3

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f11028b

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/ftgtv/ftgiptvbox/miscelleneious/b/d;->a(Landroid/content/Context;Ljava/lang/String;)V

    :cond_3
    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    const-string v2, "seriesstreams"

    const-string v3, "8"

    const-string v4, "Failed"

    invoke-virtual {v1, v2, v3, v4, v0}, Lcom/ftgtv/ftgiptvbox/b/b/k;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b()V

    const-string v0, "redirect_live_tv"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/LiveActivityNewFlow;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    :goto_0
    invoke-virtual {p0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->startActivity(Landroid/content/Intent;)V

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->finish()V

    return-void

    :cond_4
    const-string v0, "redirect_vod"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/VodActivityNewFlow;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_0

    :cond_5
    const-string v0, "redirect_series"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/SeriesActivtyNewFlow;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_0

    :cond_6
    const-string v0, "redirect_catchup"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/TVArchiveActivityNewFlow;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_0

    :cond_7
    const-string v0, "redirect_live_tv_epg_expired"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_8

    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/ImportEPGActivity;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v0, "redirect_live_tv_epg_expired"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_0

    :cond_8
    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/NewDashboardActivity;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    goto :goto_0

    :cond_9
    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 5

    iget p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I


    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_0

    const-string p1, "loginPrefs"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v0, "username"

    const-string v1, ""

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v1, "password"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$4;

    invoke-direct {v2, p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$4;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Ljava/lang/String;Ljava/lang/String;)V

    const-wide/16 v3, 0x3e8

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_0
    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/ftgtv/ftgiptvbox/b/a/e;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    if-eqz p1, :cond_2

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    invoke-virtual {v1}, Lcom/ftgtv/ftgiptvbox/b/b/d;->k()V

    :cond_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x11

    if-lt v2, v3, :cond_1

    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$a;

    iget-object v3, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v2, p0, v3, v1, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$a;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;ILjava/util/List;)V

    sget-object p1, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array v0, v0, [Ljava/lang/String;

    invoke-virtual {v2, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$a;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$a;

    iget-object v3, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v2, p0, v3, v1, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$a;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;ILjava/util/List;)V

    new-array p1, v0, [Ljava/lang/String;

    invoke-virtual {v2, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$a;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_2
    iget p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I


    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_3

    const-string p1, "loginPrefs"

    invoke-virtual {p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v0, "username"

    const-string v1, ""

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v1, "password"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz p1, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_3

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_3

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$3;

    invoke-direct {v2, p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$3;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Ljava/lang/String;Ljava/lang/String;)V

    const-wide/16 v3, 0x3e8

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_3
    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 5

    iget p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I


    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_0

    const-string p1, "loginPrefs"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v0, "username"

    const-string v1, ""

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v1, "password"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$6;

    invoke-direct {v2, p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$6;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Ljava/lang/String;Ljava/lang/String;)V

    const-wide/16 v3, 0x3e8

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_0
    return-void
.end method

.method public d(Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/ftgtv/ftgiptvbox/b/a/s;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    if-eqz p1, :cond_2

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    invoke-virtual {v1}, Lcom/ftgtv/ftgiptvbox/b/b/d;->l()V

    :cond_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x11

    if-lt v2, v3, :cond_1

    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$e;

    iget-object v3, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v2, p0, v3, v1, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$e;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;ILjava/util/List;)V

    sget-object p1, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array v0, v0, [Ljava/lang/String;

    invoke-virtual {v2, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$e;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$e;

    iget-object v3, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v2, p0, v3, v1, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$e;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;ILjava/util/List;)V

    new-array p1, v0, [Ljava/lang/String;

    invoke-virtual {v2, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$e;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_2
    iget p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I


    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_3

    const-string p1, "loginPrefs"

    invoke-virtual {p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v0, "username"

    const-string v1, ""

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v1, "password"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz p1, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_3

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_3

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$5;

    invoke-direct {v2, p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$5;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Ljava/lang/String;Ljava/lang/String;)V

    const-wide/16 v3, 0x3e8

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_3
    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 5

    iget p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I


    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    const-string v1, "Channels"

    const-string v2, "1"

    const-string v3, "Failed"

    invoke-virtual {v0, v1, v2, v3, p1}, Lcom/ftgtv/ftgiptvbox/b/b/d;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    :cond_0
    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v0, "username"

    const-string v1, ""

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v1, "password"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$8;

    invoke-direct {v2, p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$8;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Ljava/lang/String;Ljava/lang/String;)V

    const-wide/16 v3, 0x3e8

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_1
    return-void
.end method

.method public e(Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/ftgtv/ftgiptvbox/b/a/f;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_2

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    invoke-virtual {v0}, Lcom/ftgtv/ftgiptvbox/b/b/d;->n()V

    :cond_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x11

    const/4 v3, 0x0

    if-lt v1, v2, :cond_1

    new-instance v1, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$b;

    iget-object v2, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v1, p0, v2, v0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$b;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;ILjava/util/List;)V

    sget-object p1, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array v0, v3, [Ljava/lang/String;

    invoke-virtual {v1, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$b;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-instance v1, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$b;

    iget-object v2, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v1, p0, v2, v0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$b;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;ILjava/util/List;)V

    new-array p1, v3, [Ljava/lang/String;

    invoke-virtual {v1, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$b;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_2
    iget p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I


    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_4

    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_3

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    const-string v1, "Channels"

    const-string v2, "1"

    const-string v3, "Failed"

    invoke-virtual {v0, v1, v2, v3, p1}, Lcom/ftgtv/ftgiptvbox/b/b/d;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    :cond_3
    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v0, "username"

    const-string v1, ""

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v1, "password"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz p1, :cond_4

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_4

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_4

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$7;

    invoke-direct {v2, p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$7;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Ljava/lang/String;Ljava/lang/String;)V

    const-wide/16 v3, 0x3e8

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_4
    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 4

    iget p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I


    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    const-string v1, "Channels"

    const-string v2, "1"

    const-string v3, "Failed"

    invoke-virtual {v0, v1, v2, v3, p1}, Lcom/ftgtv/ftgiptvbox/b/b/d;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    :cond_0
    const-string p1, "loginPrefs"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v0, "username"

    const-string v1, ""

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v1, "password"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->f:Lcom/ftgtv/ftgiptvbox/c/d;

    invoke-virtual {v1, p1, v0}, Lcom/ftgtv/ftgiptvbox/c/d;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method public f(Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/ftgtv/ftgiptvbox/b/a/u;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    if-eqz p1, :cond_2

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    invoke-virtual {v1}, Lcom/ftgtv/ftgiptvbox/b/b/d;->o()V

    :cond_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x11

    if-lt v2, v3, :cond_1

    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$f;

    iget-object v3, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v2, p0, v3, v1, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$f;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;ILjava/util/List;)V

    sget-object p1, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array v0, v0, [Ljava/lang/String;

    invoke-virtual {v2, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$f;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-instance v2, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$f;

    iget-object v3, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {v2, p0, v3, v1, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$f;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;Landroid/content/Context;ILjava/util/List;)V

    new-array p1, v0, [Ljava/lang/String;

    invoke-virtual {v2, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity$f;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_2
    iget p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->h:I


    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    if-eqz p1, :cond_4

    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_3

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    const-string v2, "Channels"

    const-string v3, "1"

    const-string v4, "Failed"

    invoke-virtual {v1, v2, v3, v4, p1}, Lcom/ftgtv/ftgiptvbox/b/b/d;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    :cond_3
    const-string p1, "loginPrefs"

    invoke-virtual {p0, p1, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v0, "username"

    const-string v1, ""

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e:Landroid/content/SharedPreferences;

    const-string v1, "password"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz p1, :cond_4

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_4

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_4

    iget-object v1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->f:Lcom/ftgtv/ftgiptvbox/c/d;

    invoke-virtual {v1, p1, v0}, Lcom/ftgtv/ftgiptvbox/c/d;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_4
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 8

    invoke-super {p0, p1}, Landroid/support/v7/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->requestWindowFeature(I)Z

    const p1, 0x7f0d0031

    invoke-virtual {p0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->setContentView(I)V

    invoke-static {p0}, Lbutterknife/ButterKnife;->a(Landroid/app/Activity;)Lbutterknife/Unbinder;

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->tvImportingStreams:Landroid/widget/TextView;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->tvImportingStreams:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f110125

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_0
    iget-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->tvSettingStreams:Landroid/widget/TextView;

    if-eqz p1, :cond_1

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f11038d

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_1
    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->f()V

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    const/16 v0, 0x400

    invoke-virtual {p1, v0, v0}, Landroid/view/Window;->setFlags(II)V

    iput-object p0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    new-instance p1, Lcom/ftgtv/ftgiptvbox/b/b/d;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {p1, v0}, Lcom/ftgtv/ftgiptvbox/b/b/d;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->b:Lcom/ftgtv/ftgiptvbox/b/b/d;

    new-instance p1, Lcom/ftgtv/ftgiptvbox/b/b/k;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {p1, v0}, Lcom/ftgtv/ftgiptvbox/b/b/k;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->g:Lcom/ftgtv/ftgiptvbox/b/b/k;

    new-instance p1, Lcom/ftgtv/ftgiptvbox/c/d;

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-direct {p1, v0, p0}, Lcom/ftgtv/ftgiptvbox/c/d;-><init>(Landroid/content/Context;Lcom/ftgtv/ftgiptvbox/view/b/i;)V

    iput-object p1, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->f:Lcom/ftgtv/ftgiptvbox/c/d;

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    const-string v1, "redirect_"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_5

    :cond_2
    const-string v0, "tvaqui_sync"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "last_full_sync"

    const-wide/16 v2, 0x0

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    sub-long/2addr v6, v2

    const-wide/32 v4, 0x36ee80

    div-long/2addr v6, v4

    long-to-int v6, v6

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v7

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GATE: ultimo sync ha "

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "h"

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v4, 0x0

    invoke-static {v7, v1, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-lez v1, :cond_5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    sub-long/2addr v4, v2

    const-wide/16 v6, 0x0

    cmp-long v1, v4, v6

    if-ltz v1, :cond_3

    const-wide/32 v6, 0x5265c00

    cmp-long v1, v4, v6

    if-gez v1, :cond_5

    :cond_3
    const-string v1, "last_full_sync_user"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    if-nez v3, :cond_4

    const-string v0, "loginPrefs"

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v2}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v2, "username"

    const-string v3, ""

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    :cond_4
    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "OK 24H - sem atualizar"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/ftgtv/ftgiptvbox/view/activity/NewDashboardActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->startActivity(Landroid/content/Intent;)V

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->finish()V

    return-void

    :cond_5
    invoke-direct {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->c()V

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->tvaquiWd:Landroid/os/Handler;

    new-instance v1, Lcom/ftgtv/ftgiptvbox/view/activity/ImportWatchdog;

    const/4 p1, 0x0

    invoke-direct {v1, p0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportWatchdog;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;I)V

    const-wide/32 v2, 0x249f0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    new-instance v1, Lcom/ftgtv/ftgiptvbox/view/activity/ImportWatchdog;

    const/4 p1, 0x1

    invoke-direct {v1, p0, p1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportWatchdog;-><init>(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;I)V

    const-wide/32 v2, 0x927c0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method protected onDestroy()V
    .locals 4

    invoke-super {p0}, Landroid/support/v7/app/AppCompatActivity;->onDestroy()V

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->tvaquiWd:Landroid/os/Handler;

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->e(Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;)I

    move-result v0

    const/4 v0, 0x0

    if-lez v0, :cond_1

    const-string v0, "tvaqui_sync"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "last_full_sync"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "loginPrefs"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v2, "username"

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "last_full_sync_user"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    return-void

    :catch_0
    move-exception v0

    return-void
.end method

.method public onResume()V
    .locals 2

    invoke-super {p0}, Landroid/support/v7/app/AppCompatActivity;->onResume()V

    iget-object v0, p0, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/ftgtv/ftgiptvbox/miscelleneious/b/d;->j(Landroid/content/Context;)V

    invoke-virtual {p0}, Lcom/ftgtv/ftgiptvbox/view/activity/ImportStreamsActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x400

    invoke-virtual {v0, v1, v1}, Landroid/view/Window;->setFlags(II)V

    return-void
.end method
